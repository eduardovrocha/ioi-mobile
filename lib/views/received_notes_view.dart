import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mrcatcash/views/professional_account_view.dart';
import 'package:mrcatcash/widgets/modals/modal_configuration_form_widget.dart';
import 'package:mrcatcash/widgets/update_profile_screen_widget.dart';
import 'package:yaml/yaml.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:io' show Platform;

import '../widgets/components/copyable_wallet_number_widget.dart';
import '../widgets/modals/modal_campaign_form_widget.dart';
import '../widgets/sections/section_area_panel_widget.dart';
import '../widgets/whats_app_group_link_widget.dart';
import 'collects_view.dart';
import 'coming_binds_view.dart';

import '../services/api_service.dart';
import '../widgets/qr_scanner_widget.dart';
import '../widgets/lists/received_note_list_widget.dart';
import '../widgets/components/custom_snackbar_widget.dart';
import '../models/profile_data.dart';

class ReceivedNotesView extends StatefulWidget {
  const ReceivedNotesView({super.key, required this.profileData, required this.message});

  final ProfileData profileData;
  final Map<String, dynamic> message;

  @override
  _ReceivedNotesViewState createState() => _ReceivedNotesViewState();
}

class _ReceivedNotesViewState extends State<ReceivedNotesView> {

  String appVersion = 'v.1.0.1 - Fluffy You';
  final PageController _pageController = PageController(initialPage: 1);
  final ApiService apiService = ApiService();
  String? _uniqueId;

  Future<Map<String, dynamic>> fetchShards() async {
    return apiService.fetchShards('');
  }
  Future<Map<String, dynamic>> fetchComingBinds() async {
    return apiService.fetchComingBinds();
  }
  Future<Map<String, dynamic>> fetchReceivedNotes() async {
    return apiService.fetchReceivedNotes();
  }
  Future<Map<String, dynamic>> fetchCollects() async {
    return apiService.fetchCollects();
  }
  Future<Future<Map<String, dynamic>>> fetchPresences() async {
    return apiService.fetchPresences();
  }

  late Future<List<dynamic>> receivedNotesFuture;
  late Future<ProfileData> profileDataFuture;
  late List profilePresences = [];

  late final Map<String, dynamic> messageAfterUpdate = widget.message;
  late ProfileData profileData = widget.profileData;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    apiService.fetchPresences().then((result) {
      setState(() {
        profilePresences = result['data'];
      });
    });

    var available = messageAfterUpdate['available'] ?? false;

    if ((available != null) && (available == true)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {

        MessageType messageType = MessageType.values.firstWhere(
          (e) => e.toString().split('.').last == messageAfterUpdate['type'],
          orElse: () => MessageType.info, /* default value */
        );

        CustomSnackbarWidget.show(
          context, message: messageAfterUpdate['message'],
          type: messageType, actionLabel: "",
          onActionPressed: () {},
        );
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });

    /* open QR code when click on "Vouchers" */
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QRScannerWidget(profileData: profileData)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) async {
          print('---> ReceivedNotesView, onPageChanged, index: $index');

          fetchPresences();

          if (index == 0) {
            fetchComingBinds();
          }
          if (index == 1) {
            fetchReceivedNotes();
          }
          if (index == 2) {
            fetchCollects();
          }
          if (index == 3) {

          }

          if ((index == 1) && (messageAfterUpdate.isNotEmpty)) {
            /* CustomSnackbarWidget.show(
              context, message: messageAfterUpdate,
              type: MessageType.talk, actionLabel: 'Ok',
              onActionPressed: () {},
            ); */
          }

          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          ComingBindsView(data: profileData),
          Scaffold(
            appBar: AppBar(
              title: const Text(
                'Envios', style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xFFFED86A),
              titleTextStyle: const TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 20, fontWeight: FontWeight.bold
              ),),
            backgroundColor: const Color(0xFFF5F5F5),
            body: Stack(
              children: [
                Column(
                  children: [
                    SectionAreaPanelWidget(uniqueId: profileData.uniqueId, viewNameFor: 'received_note'),
                    ReceivedNoteListWidget()
                  ],
                ),
              ],
            ),
          ),
          CollectsView(profileData: profileData),
          if (profilePresences.isNotEmpty)
            ProfessionalAccountView(profileData: profileData)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFF5F5F5),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedLabelStyle: const TextStyle(
          fontSize: 14,
          height: 2.5,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          height: 2.5,
        ),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/resources-037.png',
              width: 31,
              height: 31,
            ),
            label: 'Executado',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 30, height: 30,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/resources-021.png',
                  width: 32, height: 32,
                ),
              ),
            ),
            label: 'Notas',
            tooltip: 'Envie QR Code de suas compras',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/resources-029.png',
              width: 30, height: 30,
            ),
            label: '\$MC3',
          ),
          if (profilePresences.isNotEmpty)
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/resources-022.png',
                width: 30, height: 30,
              ),
              label: 'Comercial',
            ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }

}

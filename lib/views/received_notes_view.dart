import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mrcatcash/views/configurations_view.dart';
import 'package:mrcatcash/widgets/modal/modal_configuration_form_widget.dart';
import 'package:yaml/yaml.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:io' show Platform;

import '../widgets/copyable_wallet_number_widget.dart';
import '../widgets/modal/modal_campaign_form_widget.dart';
import '../widgets/whats_app_group_link_widget.dart';
import 'collects_view.dart';
import 'coming_binds_view.dart';

import '../services/api_service.dart';
import '../widgets/qr_scanner_widget.dart';
import '../widgets/received_note_list_widget.dart';
import '../widgets/custom_snackbar_widget.dart';
import '../models/profile_data.dart';

class ReceivedNotesView extends StatefulWidget {
  const ReceivedNotesView({super.key, required this.profileData});

  final ProfileData profileData;

  @override
  _ReceivedNotesViewState createState() => _ReceivedNotesViewState();
}

class _ReceivedNotesViewState extends State<ReceivedNotesView> {
  String appVersion = 'v.1.0.1 - Fluffy You';
  final PageController _pageController = PageController(initialPage: 1);
  final ApiService apiService = ApiService();
  String? _uniqueId;

  Future<Map<String, dynamic>> fetchShards() async {
    return apiService.fetchShards();
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

  late ProfileData profileData = widget.profileData;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    apiService.fetchProfileData().then((result) {
      setState(() {
        profileData = result;
      });
    });
    apiService.fetchPresences().then((result) {
      setState(() {
        profilePresences = result['data'];
      });
    });
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
    /* late ProfileData profileData = widget.profileData; */
    print('-->');
    print(profilePresences);
    print('-->');

    return Scaffold(
      /* main content */
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          print('----> $index');/*  */

          apiService.fetchProfileData().then((result) {
            setState(() {
              profileData = result;
            });
          });

          fetchPresences();
          fetchShards();

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

          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          ComingBindsView(data: profileData),
          Scaffold(
            appBar: AppBar(
              title: const Text(
                'Vouchers',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              automaticallyImplyLeading: false,
              // Removes the back button
              backgroundColor: const Color(0xFFFED86A),
              titleTextStyle: const TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              leading: Builder(
                builder: (context) {
                  return IconButton(
                    icon: Image.asset(
                      'assets/images/menu-left.png',
                      width: 30,
                      height: 30,
                    ),
                    onPressed: () {
                      Scaffold.of(context)
                          .openDrawer(); /* Open the drawer */
                    },
                  );
                },
              ),
              /* actions: [
                  IconButton(
                    icon: Image.asset(
                      'assets/images/menu-qrcode.png',
                      width: 28, height: 28,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context, MaterialPageRoute(builder: (context) => QRScannerWidget(profileData: profileData)),
                      );
                    },
                  ),
                ], */
            ),
            /*  app main bar  */
            backgroundColor: const Color(0xFFF5F5F5),
            drawer: _buildDrawer(context, profileData, profilePresences),
            body: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      constraints: const BoxConstraints(
                        minHeight: 60,
                        minWidth: double.infinity,
                        maxWidth: double.infinity,
                      ),
                      child: Column(
                        children: [
                          /* sub title space */
                          const Padding(
                            padding: EdgeInsets.only(top: 24.0),
                            child: Stack(),
                          ),
                          CopyableWalletNumberWidget(
                              uniqueId: profileData.uniqueId),
                        ],
                      ),
                    ),
                    /*  header  */
                    Container(
                      constraints: const BoxConstraints(
                        minWidth: double.infinity,
                        maxWidth: double.infinity,
                      ),
                      child: const Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(''),
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Stack(),
                                ),
                                Text(''),
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Stack(),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Stack(),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Stack(),
                                ),
                                Text(''),
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Stack(),
                                ),
                                Text(''),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ReceivedNoteListWidget()
                  ],
                ),
              ],
            ),
          ),
          CollectsView(data: profileData),
          if (profilePresences.isNotEmpty)
            ConfigurationsView(profileData: profileData)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFF5F5F5),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/resources-006.png',
              width: 24,
              height: 24,
            ),
            label: 'Histórico',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                shape: BoxShape.circle, // Torna o container circular
                /* color: Color(0xFFFED86A), */
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/resources-021.png',
                  width: 24, // Tamanho da imagem
                  height: 24,
                ),
              ),
            ),
            label: 'Vouchers',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/resources-016.png',
              width: 24,
              height: 24,
            ),
            label: 'Recompensas',
          ),
          if (profilePresences.isNotEmpty)
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/resources-022.png',
                width: 24, height: 24,
              ),
              label: 'Business',
            ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context, profileData, profilePresences) {
    var activeProfile = widget.profileData;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFFFED86A)),
              child: Text(appVersion)),
          ListTile(
            leading: Image.asset(
              'assets/images/resources-012.png',
              width: 32.0,
              height: 32.0,
              fit: BoxFit.contain,
            ),
            title: const Text('Fluffy Ball',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15)),
            onTap: () {
              CustomSnackbarWidget.show(
                context,
                message: 'Perfil ainda não confirmado',
                type: MessageType.talk,
                actionLabel: 'Ver detalhes',
                onActionPressed: () {
                  print('Ação do botão clicada!');
                },
              );
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/resources-012.png',
              width: 32.0,
              height: 32.0,
              fit: BoxFit.contain,
            ),
            title: const Text(
              'Configuração',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 15,
              ),
            ),
            onTap: () {
              ModalConfigurationFormWidget.show(context, profileData, profilePresences);
            },
          ),
          ListTile(
            title: WhatsAppGroupLinkWidget(
              groupUrl: 'https://chat.whatsapp.com/JpV6E3uIsQp980vjdIRKFR',
              linkText: 'Teste Fechado - WhatsApp',
            ).getLink(context),
          ),
          /*  */
        ],
      ),
    );
  }
}

class ProfileDataProvider extends InheritedWidget {
  final ProfileData profileData;

  const ProfileDataProvider({
    super.key,
    required this.profileData,
    required super.child,
  });

  static ProfileDataProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProfileDataProvider>();
  }

  @override
  bool updateShouldNotify(ProfileDataProvider oldWidget) {
    return profileData != oldWidget.profileData;
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mrcatcash/views/received_notes_view.dart';
import 'package:mrcatcash/widgets/campaign_list_widget.dart';
import 'package:mrcatcash/widgets/modal/modal_campaign_form_widget.dart';
import '../widgets/copyable_wallet_number_widget.dart';
import '../services/api_service.dart';
import '../models/profile_data.dart';

class ConfigurationsView extends StatefulWidget {
  const ConfigurationsView({super.key, required this.profileData});

  final ProfileData profileData;

  @override
  _ConfigurationsViewState createState() => _ConfigurationsViewState();
}

class _ConfigurationsViewState extends State<ConfigurationsView> {
  String appVersion = 'v.1.0.1 - Fluffy You';

  final PageController _pageController = PageController(initialPage: 0);
  final ApiService apiService = ApiService();

  String? _uniqueId;
  late ProfileData profileData = widget.profileData;
  int _selectedIndex = 4;

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          Scaffold(
            appBar: AppBar(
              title: const Text(
                'Business',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xFFFED86A),
              titleTextStyle: const TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: const Color(0xFFF5F5F5),
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
                          const Padding(
                            padding: EdgeInsets.only(top: 24.0),
                            child: Stack(),
                          ),
                          CopyableWalletNumberWidget(uniqueId: profileData.uniqueId),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      constraints: const BoxConstraints(
                        minHeight: 60,
                        minWidth: double.infinity,
                        maxWidth: double.infinity,
                      ),
                      child: Row(
                        /* MainAxisAlignment.spaceAround */
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Container central com fundo branco
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(6),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      children: [
                                        RichText(
                                          textAlign: TextAlign.center,
                                          text: const TextSpan(
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black38,
                                              height: 1.7,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: 'Saldo\n',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                  color: Colors.green,
                                                ),
                                              ),
                                              TextSpan(
                                                text: '1000',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 28,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' \$MC3',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' \n ,00000 un.',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                                const SizedBox(width: 10),
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      children: [
                                        RichText(
                                          textAlign: TextAlign.center,
                                          text: const TextSpan(
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black38,
                                              height: 1.7,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: 'Alocado\n',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22,
                                                  color: Colors.blueAccent,
                                                ),
                                              ),
                                              TextSpan(
                                                text: '0',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 28,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' \$MC3',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' \n ,00000 un.',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                              child: CampaignListWidget()
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              ModalCampaignFormWidget.show(context);
                            },
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.symmetric(horizontal: 20),
                              decoration: const BoxDecoration(
                                /* color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.blue), */
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.edit, color: Colors.blue),
                                  SizedBox(width: 8),
                                  Text(
                                    'Editar Campanha',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

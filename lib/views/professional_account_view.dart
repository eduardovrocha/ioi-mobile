import 'package:flutter/material.dart';
import 'package:mrcatcash/widgets/modals/modal_activation_proffesional_account_form_widget.dart';
import 'package:mrcatcash/widgets/sections/content/balance_widget.dart';
import '../widgets/lists/campaign_list_widget.dart';
import '../services/api_service.dart';
import '../models/profile_data.dart';
import '../widgets/sections/section_area_panel_widget.dart';
import '../widgets/whats_app_group_link_widget.dart';

class ProfessionalAccountView extends StatefulWidget {
  const ProfessionalAccountView({super.key, required this.profileData});

  final ProfileData profileData;
  // final List profilePresences;

  @override
  _ProfessionalAccountViewState createState() => _ProfessionalAccountViewState();
}

class _ProfessionalAccountViewState extends State<ProfessionalAccountView> {
  final ApiService apiService = ApiService();
  final PageController _pageController = PageController(initialPage: 0);

  String? _uniqueId;

  late ProfileData profileData = widget.profileData;
  late List profilePresences = widget.profileData.presences as List;

  bool activationReady = false;
  int _selectedIndex = 3;

  @override
  void initState() {
    super.initState();
  }

  Widget _buildDrawer(BuildContext context) {
    String appVersion = 'v.1.0.3 - Fluffy You';
    var activeProfile = widget.profileData;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFFFED86A), // Cor de fundo do header
            ),
            child: WhatsAppGroupLinkWidget(
              groupUrl: 'https://chat.whatsapp.com/JpV6E3uIsQp980vjdIRKFR',
              linkText: 'Teste Fechado - WhatsApp',
            ).getLink(context),
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/resources-022.png',
              width: 32.0, height: 32.0,
              fit: BoxFit.contain,
            ),
            title: const Text(
              'EVR Desenvolvimento ...',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {},
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final professionalProfileAccount = profileData.presences.professional['activation'];
    final personalProfileAccount = profileData.presences.personal['activation'];

    String professionalProfileKey;
    String personalProfileStatus;
    String personalProfileKey;
    String professionalProfileStatus = '';

    String profileTokenAmount = profileData.tokens.amount;
    String profileTokenAllocated = profileData.tokens.allocated;
    String profileTokenCollected = profileData.tokens.allocated;

    bool hasProfessionalAccount = false;
    bool isProfessionalAccountActive = false;

    setState(() {
      professionalProfileStatus = professionalProfileAccount['status'];
      professionalProfileKey = professionalProfileAccount['key'];

      hasProfessionalAccount = professionalProfileAccount['status'].length > 0;
      isProfessionalAccountActive = professionalProfileAccount['status'] == '1';
    });

    if (professionalProfileAccount['key'].length > 0) {
      setState(() {
        // hasProfessionalAccount: true;
      });
    }

    if (personalProfileAccount['key'].length > 0) {
      setState(() {
        personalProfileStatus = personalProfileAccount['status'];
        personalProfileKey = personalProfileAccount['key'];
      });
    }

    print('professionalProfileAccount ${professionalProfileAccount}');
    /* print('personalProfileAccount ${personalProfileAccount}'); */

    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFFED86A),
        title: const Text('', style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold,
          ), textAlign: TextAlign.center ),
        actions: [
          Builder(builder: (context) {
              return IconButton(
                icon: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..scale(-1.0, 1.0),
                  child: Image.asset(
                    'assets/images/background-cat-ii.gif',
                    width: 42, height: 42,
                  ),
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            }),
        ],
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      drawer: _buildDrawer(context),
      /* body: PageView(
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
                '',
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
              actions: [
                Builder(
                  builder: (context) {
                    return IconButton(
                      icon: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..scale(-1.0, 1.0),
                        child: Image.asset(
                          'assets/images/background-cat-ii.gif',
                          width: 42, height: 42,
                        ),
                      ),
                      onPressed: () {
                        Scaffold.of(context)
                            .openEndDrawer(); // Open the right drawer
                      },
                    );
                  },
                ),
              ],
            ),
            backgroundColor: const Color(0xFFF5F5F5),
            drawer: _buildDrawer(context),
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
                          SectionAreaPanelWidget(profile: profileData, viewNameFor: 'received_note'),
                          Container(
                            constraints: const BoxConstraints(
                              minHeight: 60,
                              minWidth: double.infinity,
                              maxWidth: double.infinity,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6),
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
                                                text: TextSpan(
                                                  style: const TextStyle(
                                                    fontSize: 22,
                                                    color: Colors.black38,
                                                    height: 1.7,
                                                  ),
                                                  children: <TextSpan>[
                                                    const TextSpan(
                                                      text: 'Saldo\n',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 22,
                                                        color: Colors.green,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                      '${profileTokenAmount.split(',')[0]},',
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 32,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                    /* const TextSpan(
                                                text: ' \$MC3',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: Colors.black87,
                                                ),
                                              ), */
                                                    TextSpan(
                                                      text: ' \n'
                                                          '${profileTokenAmount.split(',')[1]} \$MC3',
                                                      style: const TextStyle(
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
                                                text: TextSpan(
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black38,
                                                    height: 1.7,
                                                  ),
                                                  children: <TextSpan>[
                                                    const TextSpan(
                                                      text: 'Alocado\n',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 22,
                                                        color: Colors.blueAccent,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                      '${profileTokenAllocated.split(',')[0]},',
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 32,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                      '\n${profileTokenAllocated.split(',')[1]} \$MC3',
                                                      style: const TextStyle(
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
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          isProfessionalAccountActive
                              ? Expanded(child: CampaignListWidget())
                              : GestureDetector(
                                  onTap: !hasProfessionalAccount
                                      ? () async {
                                          ModalActivationProfessionalAccountFormWidget
                                              .show(context, profileData, profilePresences);
                                        }
                                      : null,
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.check,
                                            color: (
                                                !hasProfessionalAccount
                                                ? Colors.blue : Colors.grey)
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Ativar Conta Business',
                                          style: TextStyle(
                                            color: !hasProfessionalAccount
                                                ? Colors.blue : Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ), */
      body: Column(
        children: [
          SectionAreaPanelWidget(uniqueId: profileData.uniqueId, viewNameFor: 'professional_account'),
          Expanded(
            child: Column(
              children: [
                isProfessionalAccountActive
                    ? Expanded(child: CampaignListWidget())
                    : GestureDetector(
                        onTap: !hasProfessionalAccount
                            ? () async {
                                ModalActivationProfessionalAccountFormWidget
                                    .show(context, profileData, profilePresences);
                              }
                            : null,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check,
                                  color: (!hasProfessionalAccount
                                      ? Colors.blue
                                      : Colors.grey)),
                              const SizedBox(width: 8),
                              Text(
                                'Ativar Conta Business',
                                style: TextStyle(
                                  color: !hasProfessionalAccount
                                      ? Colors.blue
                                      : Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

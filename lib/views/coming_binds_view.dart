import 'package:flutter/material.dart';
import 'package:mrcatcash/models/profile_data.dart';
import 'package:mrcatcash/widgets/lists/coming_bind_list_widget.dart';
import 'package:mrcatcash/widgets/components/copyable_wallet_number_widget.dart';
import 'package:mrcatcash/widgets/sections/section_area_panel_widget.dart';
import '../services/api_service.dart';
import '../widgets/components/custom_snackbar_widget.dart';
import '../widgets/modals/modal_configuration_form_widget.dart';
import '../widgets/update_profile_screen_widget.dart';
import '../widgets/whats_app_group_link_widget.dart';

class ComingBindsView extends StatefulWidget {
  const ComingBindsView({super.key, required this.data});

  final ProfileData data;

  @override
  _ComingBindsViewState createState() => _ComingBindsViewState();
}

class _ComingBindsViewState extends State<ComingBindsView> {
  final ApiService apiService = ApiService();

  late ProfileData profile = widget.data;
  late Map shard = {};

  Future<Map<String, dynamic>> fetchComingBinds() async {
    return apiService.fetchReceivedNotes();
  }
  Future<Map<String, dynamic>> fetchShards() async {
    return apiService.fetchShards('');
  }

  late Future<List<dynamic>> comingBindsFuture; // Fetching binds
  late Future<List<dynamic>> comingShardsFuture;

  @override
  void initState() {
    super.initState();
  }

  Widget _buildDrawer(BuildContext context, profileData, profilePresences) {
    String appVersion = 'v.1.0.1 - Fluffy You';
    var activeProfile = widget.data;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFFFED86A)),
              child: WhatsAppGroupLinkWidget(
                groupUrl: 'https://chat.whatsapp.com/JpV6E3uIsQp980vjdIRKFR',
                linkText: 'Teste Fechado - WhatsApp',
              ).getLink(context)),
          ListTile(
            leading: Image.asset(
              'assets/images/paw-mark.png',
              width: 32.0, // Largura da imagem
              height: 32.0, // Altura da imagem
              fit: BoxFit.contain, // Ajusta o tamanho da imagem conforme necessário
            ),
            title: const Text(
              'Pawllet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: null,
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/resources-037.png',
              width: 32.0,
              height: 32.0,
              fit: BoxFit.contain,
            ),
            title: Text(
              'R\$ ${activeProfile.currency.amount} *',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: null,
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/resources-029.png',
              width: 32.0,
              height: 32.0,
              fit: BoxFit.contain,
            ),
            title: Text(
              '${activeProfile.tokens.amount} \$MC3',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: null,
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/resources-018.png',
              width: 32.0,
              height: 32.0,
              fit: BoxFit.contain,
            ),
            title: const Text(
              '0,0%',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
            onTap: null,
          ),
          const Divider(color: Colors.black12, height: 1),
          ListTile(
            leading: Image.asset(
              'assets/images/menu-settings.png',
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
              ModalConfigurationFormWidget.show(
                  context, profileData, profilePresences);
            },
          ),
          const Divider(color: Colors.black12, height: 1),
          ListTile(
            leading: Image.asset(
              'assets/images/resources-026.png',
              width: 32.0,
              height: 32.0,
              fit: BoxFit.contain,
            ),
            title: const Text(
              '~ ! clear ! ~',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 15,
              ),
            ),
            onTap: () {
              apiService.cleanPresence().then((result) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const UpdateProfileScreenWidget(message: {
                              "type": "info",
                              "message": "informações do perfil foram limpas"
                            })));
              });
            },
          ), // Outro divisor
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var activeProfile = profile;

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
            },
          )
        ],
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      drawer: _buildDrawer(context, activeProfile, []),
      body: Column(
        children: [
          SectionAreaPanelWidget(
              uniqueId: activeProfile.uniqueId, viewNameFor: 'coming_bind'
          ),
          const ComingBindListWidget()
        ],
      ),
    );
  }
}

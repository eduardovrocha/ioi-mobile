import 'package:flutter/material.dart';
import 'package:binbin/models/profile_data.dart';
import 'package:binbin/widgets/collect_list_widget.dart';
import '../services/api_service.dart';

class CollectsView extends StatefulWidget {
  // final Map<String, dynamic> data;  // Make it nullable
  const CollectsView({super.key, required this.data});
  final ProfileData data;  // Make it nullable

  @override
  _CollectsViewState createState() => _CollectsViewState();
}

class _CollectsViewState extends State<CollectsView> {
  final ApiService apiService = ApiService(); // Initialize the API service

  Future<Map<String, dynamic>> fetchCollects() async {
    return apiService.fetchCollects();
  }
  late Future<List<dynamic>> collectsFuture; // Fetching binds

  @override
  void initState() {
    super.initState();
  }

  Widget _buildRightDrawer(BuildContext context) {
    var activeProfile = widget.data;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFFFED86A)),
            child: Text('v.0.0.1')
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/resources-010.png',
              width: 24.0, // Largura da imagem
              height: 24.0, // Altura da imagem
              fit: BoxFit.contain, // Ajusta o tamanho da imagem conforme necessário
            ),
            title: const Text('Wallet', style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.bold,
            )),
            onTap: () {},
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/resources-020.png',
              width: 24.0, // Largura da imagem
              height: 24.0, // Altura da imagem
              fit: BoxFit.contain, // Ajusta o tamanho da imagem conforme necessário
            ),
            title: Text('${activeProfile.tokens.amount} \$IOIC ', style:
            const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600,
            )),
            onTap: () {},
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/resources-006.png',
              width: 24.0, // Largura da imagem
              height: 24.0, // Altura da imagem
              fit: BoxFit.contain, // Ajusta o tamanho da imagem conforme necessário
            ),
            title: Text('R\$ ${activeProfile.currency.amount} '
                '*', style:
            const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600,
            )),
            onTap: () {},
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/resources-018.png',
              width: 24.0, // Largura da imagem
              height: 24.0, // Altura da imagem
              fit: BoxFit.contain, // Ajusta o tamanho da imagem conforme necessário
            ),
            title: const Text('0,0%', style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey
            )),
            onTap: null,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var activeProfile = widget.data;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recompensas',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        automaticallyImplyLeading: false, // Removes the back button
        backgroundColor: const Color(0xFFFED86A),
        titleTextStyle: const TextStyle(
          color: Color(0xFF333333),
          fontSize: 20,
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: Image.asset(
                  'assets/images/binbin-feliz.png', // Path to your image
                  width: 36, height: 36,
                ),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer(); // Open the right drawer
                },
              );
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      endDrawer: _buildRightDrawer(context),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                constraints: const BoxConstraints(
                    minHeight: 60, minWidth: double.infinity, maxWidth: double.infinity
                ),
                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 24.0),
                      child: Stack(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pré Venda inicia em 03/11/2024',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                  ],
                ),
              ),  /* pre sale advertise */
              Container(
                constraints: const BoxConstraints(
                  minWidth: double.infinity,
                  maxWidth: double.infinity,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(activeProfile.uniqueId),
                        ],
                      ),
                    ),
                  ],
                ),
              ),  /* section info show */
              Container(
                constraints: const BoxConstraints(
                  minWidth: double.infinity,
                  maxWidth: double.infinity,
                ), // cabecalho
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 10.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('\$IOIC recebidas ${activeProfile.tokens.amount}',
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold
                                  )),
                              const SizedBox(width: 8.0),
                              Image.asset(
                                'assets/images/resources-020.png',
                                width: 24.0,
                                height: 24.0,
                                fit: BoxFit.contain,
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 15.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),  /* received tokens ($IOIC) */
              SizedBox(
                height: 10, // espaço inicial na lista
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: const EdgeInsets.only(left: 10.0),
                          width: 0, color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CollectListWidge(profileData: activeProfile)
            ],
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:mrcatcash/models/profile_data.dart';
import 'package:mrcatcash/widgets/coming_bind_list_widget.dart';
import '../services/api_service.dart';

class ComingBindsView extends StatefulWidget {
  const ComingBindsView({super.key, required this.data});
  final ProfileData data;

  @override
  _ComingBindsViewState createState() => _ComingBindsViewState();
}

class _ComingBindsViewState extends State<ComingBindsView> {
  final ApiService apiService = ApiService(); // Initialize the API service

  Future<Map<String, dynamic>> fetchComingBinds() async {
    return apiService.fetchReceivedNotes();
  }
  late Future<List<dynamic>> comingBindsFuture; // Fetching binds

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var activeProfile = widget.data;

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false, // Removes the back button
          backgroundColor: const Color(0xFFFED86A),
          title: const Text(
            'Histórico', style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold,
          ), textAlign: TextAlign.center,)
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          Container(
            constraints: const BoxConstraints(
                minHeight: 60, minWidth: double.infinity, maxWidth: double.infinity
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Text(
                    activeProfile.uniqueId,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ), /* Coming Bind Header */
          Container(
            constraints: const BoxConstraints(
                minWidth: double.infinity, maxWidth: double.infinity
            ),
            child: const Row(
              children: [
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 0.0),
                      child: Text(
                        'sharding atual 00:05:40', style:
                      TextStyle
                        (fontSize:
                      14,
                          fontWeight:
                      FontWeight.normal
                      ),
                    textAlign: TextAlign.center,
                  ),
                ))
              ],
            ),
          ),
          Container(
            constraints: const BoxConstraints(
              minWidth: double.infinity,
              maxWidth: double.infinity,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,  /* centraliza horizontal */
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
                          Text(
                              'Valores Processados R\$ ${activeProfile.currency.amount}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold
                              )),   /* display profile data */
                          const SizedBox(width: 8.0),
                          Image.asset(
                            'assets/images/resources-006.png',
                            width: 24.0, height: 24.0, fit: BoxFit.contain,
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),/* */
                    ],
                  ),
                ),
              ],
            ),
          ), // subtitulo da view
          ComingBindListWidget(profileData: activeProfile)
        ],
      ),
    );
  }
}

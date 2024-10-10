import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../views/received_notes_view.dart';
import '../services/api_service.dart';

class WelcomeWidget extends StatefulWidget {
  final String? uniqueId;
  const WelcomeWidget({super.key, this.uniqueId});

  @override
  _WelcomeWidgetState createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {
  final ApiService apiService = ApiService();
  String? _uniqueId;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFFED86A),
      appBar: AppBar(
        title: const Text('~bibin~'),
        automaticallyImplyLeading: false, // Removes the back button
        backgroundColor: const Color(0xFFFED86A), // You can customize the AppBar color
        elevation: 0, // Make AppBar flat
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.lightbulb_outline,
              size: 100,
              color: Colors.orange, // Add an icon to represent guiding the user
            ),
            const SizedBox(height: 20),
            const Text(
              'Bem vindo ;)',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text('Aqui, você ganha \$IOIC de cashback instantâneo em '
                'qualquer compra que realizar. Sem essa de expirar pontos ou '
                'trocar ponts ...',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                createNewProfile();
              }, child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                child: Text(
                  'Começar', style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  createNewProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uniqueId = prefs.getString('unique_id');

    if (uniqueId == null) {
      uniqueId = const Uuid().v4(); /*  Generate a new UUID  */
      await prefs.setString('unique_id', uniqueId); /*  Store it locally  */
      await apiService.createProfile({uniqueId: uniqueId});
    }

    var profileData = await apiService.fetchProfileData();

    Navigator.push(
      context, MaterialPageRoute(
        builder: (context) => ReceivedNotesView(
            profileData: profileData
        ))
    );
  }
}

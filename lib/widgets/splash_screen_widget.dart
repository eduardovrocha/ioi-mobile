import 'dart:async';
import 'package:flutter/material.dart';
import 'package:binbin/views/received_notes_view.dart';
import 'package:binbin/widgets/welcome_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';

class SplashScreenWidget extends StatefulWidget {
  final String? uniqueId;
  const SplashScreenWidget({super.key, this.uniqueId});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenWidget> {
  final ApiService apiService = ApiService();
  String? _uniqueId;

  @override
  void initState() {
    super.initState();
  }

  checkProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var profileId = prefs.getString('profile_id');
    var uniqueId = prefs.getString('unique_id');

    if (profileId == null && uniqueId == null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const WelcomeWidget(),
        ),
      );
    } else {
      apiService.fetchProfileData().then((profileData) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(
            builder: (context) => ReceivedNotesView(
                profileData: profileData
            ))
        );
      }).catchError((e) {
        if (uniqueId != null) {  /* Check if the key is non-null */
          apiService.createProfile({uniqueId: uniqueId}).then((profileId) {
            Timer(const Duration(seconds: 3), () async {
              apiService.fetchProfileData();
            });
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    Timer(const Duration(seconds: 3), () {
      checkProfile();
    });

    return Scaffold(
      backgroundColor: const Color(0xFFFED86A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/bibin.png',
              width: 150, height: 150,
            ),
            const SizedBox(height: 20),
            const Text(
                '~ Bibin ~',
                style: TextStyle(
                    fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white70
                )),
            const SizedBox(height: 80),
            const CircularProgressIndicator(), // Optionally add a loading
            // indicator
          ],
        ),
      ),
    );
  }
}

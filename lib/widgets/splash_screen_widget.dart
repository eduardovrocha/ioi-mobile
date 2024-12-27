import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mrcatcash/views/received_notes_view.dart';
import 'package:mrcatcash/widgets/welcome_widget.dart';
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
  String _statusMessage = 'Acordado e procurando perfil';  // Step 1:
  // Declare a status message

  @override
  void initState() {
    super.initState();
  }

  checkProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var profileId = prefs.getString('profile_id');
    var uniqueId = prefs.getString('unique_id');

    if (profileId == null && uniqueId == null) {
      setState(() {
        _statusMessage = 'olá novato, seja bem vindo';  // Update status
      });

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const WelcomeWidget(profileName: 'Anônimo',
            profileImageUrl: '', walletNumber: '1111x111-x1x1-11x1-11xx-11111111x1x1',),
        ),
      );
    } else {
      apiService.fetchProfileData().then((profileData) {
        setState(() {
          _statusMessage = 'informação do perfil ${profileId} está ativa ';
        });

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ReceivedNotesView(
                        profileData: profileData,
                        message: const {
                          "available": false,
                          "type": "",
                          "message": ""
                        })));
      }).catchError((e) {
        /* catch error and recovery
        if (uniqueId != null) {
          apiService.createProfile({uniqueId: uniqueId}).then((profileId) {
            Timer(const Duration(seconds: 3), () async {
              apiService.fetchProfileData();
            });
          });
        }
        * */
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
            const SizedBox(height: 80),
            Image.asset(
              'assets/images/mr-cat-cash.png',
              width: 300,
              height: 300,
            ),
            const SizedBox(height: 20),
            Text('~ Mr. Cat Cash ~',
                style: TextStyle(
                    fontFamily: 'Anton',
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                    color: Color(0xFF3B414B),
                    shadows: [
                      Shadow(
                        color: Color(0xFF3B414B).withOpacity(0.5),
                        offset: Offset(2, 2), blurRadius: 10,
                      ),
                    ])),
            const SizedBox(height: 80),
            const CircularProgressIndicator(),
            const SizedBox(height: 120),
            Text(_statusMessage,  // Step 3: Display the status message
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ))
          ],
        ),
      ),
    );
  }
}

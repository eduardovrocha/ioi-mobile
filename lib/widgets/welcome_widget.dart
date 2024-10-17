import 'dart:async';

import 'package:mrcatcash/views/received_notes_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../services/api_service.dart';

class WelcomeWidget extends StatefulWidget {
  final String profileName;
  final String profileImageUrl;
  final String walletNumber;
  final String? uniqueId;

  const WelcomeWidget({
    Key? key,
    required this.profileName,
    required this.profileImageUrl,
    required this.walletNumber,
    this.uniqueId,
  }) : super(key: key);

  @override
  _WelcomeWidgetState createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {
  bool _acceptTemporaryAccess = false; // Checkbox state
  bool _isButtonEnabled = true;

  final ApiService apiService = ApiService();
  String? _uniqueId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFED86A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50, // Tamanho da imagem
                    backgroundImage:
                        AssetImage('assets/images/resources-012.png'),
                  ),
                  const SizedBox(height: 10),
                  Text(widget.profileName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold, // Negrito para o nome
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    height: 2, width: 60,
                    color: Colors.grey[400], // Light grey line
                  ),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 12, color: Colors.black,
                        height: 1.5),
                      // Estilo base do texto
                      children: <TextSpan>[
                        TextSpan(
                          text: '\n    Ok \'Fluffly Ball\'. Hoje, vou '
                              'te dar um Pefil de acesso \'Visitante\' até que '
                              'consiga subir de nível. ',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(
                          text: 'Você vai receber também, uma carteira '
                              'digital, parecida com essa mostrada logo a baixo. ',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(
                          text: 'Se ganhar alguma coisa, vou enviar para ela.',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                // White background for the wallet container
                borderRadius: BorderRadius.circular(12),
                // Rounded borders
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5), // Slight shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Wallet Label
                  const Text(
                    'Carteira Digital',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Wallet Number
                  Text(
                    widget.walletNumber,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: _acceptTemporaryAccess,
                  onChanged: (bool? value) {
                    setState(() {
                      _acceptTemporaryAccess = value ?? false;
                    });
                  },
                ),
                const Text(
                  'Eu aceito criar um acesso',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isButtonEnabled ? () {
                if (_acceptTemporaryAccess) {
                  createNewProfile();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Row(
                        children: const [
                          Icon(Icons.info, color: Colors.white), // Ícone à esquerda
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Precisa aceitar criar um acesso',
                              style: TextStyle(
                                color: Colors.blueGrey, // Define a cor do texto
                                fontSize: 16, // Opcional: Define o tamanho da fonte
                              ),
                            ),
                          ),
                        ],
                      ),
                      backgroundColor: const Color(0xFFDDB3B8),
                      duration: const Duration(seconds: 5),
                      behavior: SnackBarBehavior.floating, // SnackBar flutuante
                      margin: const EdgeInsets.all(15), // Margens personalizadas
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // Bordas arredondadas
                      ),
                      action: SnackBarAction(
                        label: 'Ok',
                        textColor: Colors.blueGrey,
                        onPressed: () {},
                      ),
                    ),
                  );
                }
              } : null, // Se for null, o botão fica desabilitado
              child: Text('Criar Perfil'),
            )
          ],
        ),
      ),
    );
  }

  createNewProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uniqueId = prefs.getString('unique_id');

    setState(() {
      _isButtonEnabled = !_isButtonEnabled;
    });

    if (uniqueId == null) {
      uniqueId = const Uuid().v4(); /*  Generate a new UUID  */
      await prefs.setString('unique_id', uniqueId); /*  Store it locally  */
      await apiService.createProfile({uniqueId: uniqueId});
    }

    var profileData = await apiService.fetchProfileData();

    // Logic to create temporary access
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: const [
            Icon(Icons.info, color: Colors.white), // Ícone à esquerda
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Perfil criado com sucesso',
                style: TextStyle(
                  color: Colors.blueGrey, // Define a cor do texto
                  fontSize: 16, // Opcional: Define o tamanho da fonte
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFFB3DDBA),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating, // SnackBar flutuante
        margin: const EdgeInsets.all(15), // Margens personalizadas
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Bordas arredondadas
        ),
        action: SnackBarAction(
          label: 'Ok',
          textColor: Colors.blueGrey,
          onPressed: () {
            setState(() {
              _isButtonEnabled = !_isButtonEnabled;
            });
          },
        ),
      ),
    );

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(
              builder: (context) =>
                  ReceivedNotesView(profileData: profileData)));
    });
  }
}

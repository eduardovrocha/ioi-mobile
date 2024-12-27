import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppSupportButtonWidget extends StatelessWidget {
  final String phoneNumber = "5534996768384";
  final String message = "Olá, estou entrando em contato através do botão de "
      "suporte na ativação do Perfil Business";

  const WhatsAppSupportButtonWidget({super.key});

  void openWhatsApp() async {
    final url = "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Color okColor = const Color(0xFF57D35F);
    return ElevatedButton(
      onPressed: openWhatsApp,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: okColor, // Define o fundo verde para o botão
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(12),
      ),
      child: const Icon(Icons.message), // Ícone do WhatsApp
    );
  }
}

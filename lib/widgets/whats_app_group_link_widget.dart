import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppGroupLinkWidget {
  final String groupUrl;
  final String linkText;

  WhatsAppGroupLinkWidget({
    required this.groupUrl,
    this.linkText = 'Clique aqui para entrar no grupo do WhatsApp',
  });

  // Função que retorna a String com o texto e o link associado
  RichText getLink(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: linkText,
        style: const TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () async {
            final Uri url = Uri.parse(groupUrl);
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Não foi possível abrir o link')),
              );
            }
          },
      ),
    );
  }
}

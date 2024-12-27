import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyableWalletNumberWidget extends StatelessWidget {
  final String uniqueId; // O uniqueId a ser exibido

  const CopyableWalletNumberWidget({super.key, required this.uniqueId});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Clipboard.setData(ClipboardData(text: uniqueId)); // Copia 'a7d1-40f9-80ba'
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Número da carteira copiado!'),
              ),
            );
          },
          child: Text(
            '$uniqueId',
            style: const TextStyle(
              color: Colors.blue, // Cor do link
              decoration: TextDecoration.underline, // Estilo de link sublinhado
            ),
          ),
        )
      ],
    );
  }
}
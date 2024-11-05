import 'package:flutter/material.dart';

enum MessageType { talk, alerta, info, success, erro }

class CustomSnackbarWidget {
  static void show(
      BuildContext context, {
        required String message,
        required MessageType type,
        required String actionLabel,
        required VoidCallback onActionPressed,
      }) {
    final color = _getBackgroundColor(type);
    final icon = _getIcon(type);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
        margin: const EdgeInsets.all(16),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem quadrada alinhada à esquerda
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                color: Colors.white,
                width: 40, // Tamanho quadrado
                height: 40,
                child: icon,
              ),
            ),
            const SizedBox(width: 12),
            // Texto e botão de ação alinhados verticalmente
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message,
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 8),
                  // Botão de ação
                  /* TextButton(
                    onPressed: onActionPressed,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                    ),
                    child: Text(
                      actionLabel,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ), */
                ],
              ),
            ),
          ],
        ),
        action: SnackBarAction(
          label: 'Fechar',
          textColor: Colors.black,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  // Define a cor de fundo conforme o tipo de mensagem
  static Color _getBackgroundColor(MessageType type) {
    switch (type) {
      case MessageType.talk:
        return Color(0xFFFAFAFA);
      case MessageType.alerta:
        return Colors.orange;
      case MessageType.info:
        return Colors.blue;
      case MessageType.success:
        return Colors.green;
      case MessageType.erro:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Define o ícone conforme o tipo de mensagem
  static Widget _getIcon(MessageType type) {
    switch (type) {
      case MessageType.alerta:
        return Image.asset(
          'assets/images/resources-023.png',
          width: 24, height: 24,
        );
      case MessageType.info:
        return Image.asset(
          'assets/images/resources-023.png',
          width: 24, height: 24,
        );
      case MessageType.success:
        return Image.asset(
          'assets/images/resources-023.png',
          width: 24, height: 24,
        );
      case MessageType.erro:
        return Image.asset(
          'assets/images/resources-023.png',
          width: 24, height: 24,
        );
      default:
        return Image.asset(
          'assets/images/resources-023.png',
          width: 24, height: 24,
        );
    }
  }
}

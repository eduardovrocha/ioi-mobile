import 'package:flutter/material.dart';

class BadgesComponent extends StatelessWidget {
  final String status;
  final String label;

  const BadgesComponent({super.key, required this.status, required this.label});

  @override
  Widget build(BuildContext context) {

    final Map<String, BadgeStyle> badgeStyles = {
      'success': BadgeStyle(color: Colors.green.shade100, text: label, textColor: Colors.white),
      'new': BadgeStyle(color: Colors.yellow.shade100, text: label, textColor: Colors.black),
      'error': BadgeStyle(color: Colors.red.shade300, text: label, textColor: Colors.white),
      'active': BadgeStyle(color: Colors.blue.shade300, text: label, textColor: Colors.white),
      'inactive': BadgeStyle(color: Colors.grey.shade300, text: label, textColor: Colors.black),
    };

    final style = badgeStyles[status.toLowerCase()] ??
        BadgeStyle(color: Colors.black, text: 'UNKNOWN', textColor: Colors.black);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: const EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        color: style.color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        style.text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class BadgeStyle {
  final Color color;
  final String text;
  final Color textColor;

  BadgeStyle({required this.color, required this.text, required this.textColor});
}

import 'package:flutter/material.dart';

class BalanceWidget extends StatelessWidget {
  final String profileTokenAmount;
  final String profileTokenAllocated;

  BalanceWidget({
    required this.profileTokenAmount,
    required this.profileTokenAllocated,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Alinhamento à esquerda
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribui os elementos
            children: [
              Text(
                'Saldo',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.green,
                ),
              ),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                  children: [
                    TextSpan(
                      text: '${profileTokenAmount.split(',')[0]},',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '${profileTokenAmount.split(',')[1]} \$MC3',
                      style: const TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribui os elementos
            children: [
              const Text(
                'Alocado em Campanhas', style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14, color: Colors.blue,
                ),
              ),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 14, color: Colors.black87,
                  ),
                  children: [
                    TextSpan(
                      text: '${profileTokenAllocated.split(',')[0]},',
                      style: const TextStyle(fontWeight: FontWeight.normal),
                    ),
                    TextSpan(
                      text: '${profileTokenAllocated.split(',')[1]} \$MC3',
                      style: const TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ValueExchangeWidget extends StatefulWidget {
  final Map<String, dynamic> itemListed;
  const ValueExchangeWidget({super.key, required this.itemListed});

  @override
  _ValueExchangeWidgetState createState() => _ValueExchangeWidgetState();
}

class _ValueExchangeWidgetState extends State<ValueExchangeWidget> {
  @override
  Widget build(BuildContext context) {
    final x = widget.itemListed;

    const String creditCard = 'assets/images/resources-043.png';
    const String debitCard = 'assets/images/resources-042.png';
    const String mealVoucher = 'assets/images/resources-041.png';
    const String cash = 'assets/images/resources-040.png';
    const String others = 'assets/images/resources-039.png';

    String getPaymentImage(int? paymentType) {
      switch (paymentType) {
        case 1:
          return creditCard;
        case 2:
          return cash;
        case 3:
          return debitCard;
        case 4:
          return mealVoucher;
        default:
          return others;
      }
    }

    final int? paymentType = x['attributes']['payment_type'] as int?;
    final String selectedImage = getPaymentImage(paymentType);

    final String tokenAmount = x['attributes']['total_token_amount']?.toString() ?? 'Default Title';
    final String currencyAmount = x['attributes']['total_currency_amount']?.toString() ?? 'Default Value';

    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                selectedImage, width: 24, height: 24,
              ),
              const SizedBox(width: 8.0),
              Text(
                'R\$ $currencyAmount', style: const TextStyle(
                  fontSize: 14, color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '\$MC3 $tokenAmount',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 10.0),
              Image.asset(
                'assets/images/resources-029.png',
                width: 24, height: 24,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

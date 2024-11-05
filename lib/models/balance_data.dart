class Balance {
  String action;
  double tokenAmount;
  double currencyAmount;
  int profileId;

  /* Construtor */
  Balance({
    required this.action,
    required this.tokenAmount,
    required this.currencyAmount,
    required this.profileId,
  });

  /* Método para converter JSON em um objeto Balance */
  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      action: json['action'] ?? '',
      tokenAmount: json['token_amount']?.toDouble() ?? 0.0,
      currencyAmount: json['currency_amount']?.toDouble() ?? 0.0,
      profileId: json['profile_id'] ?? 0,
    );
  }

  /* Método para converter o objeto Balance em JSON */
  Map<String, dynamic> toJson() {
    return {
      'action': action,
      'token_amount': tokenAmount,
      'currency_amount': currencyAmount,
      'profile_id': profileId,
    };
  }
}

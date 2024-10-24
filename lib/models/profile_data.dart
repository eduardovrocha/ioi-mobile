class ProfileData {
  String uniqueId;
  DateTime createdAt;
  Vouchers vouchers;
  Tokens tokens;
  Currency currency;

  ProfileData({
    required this.uniqueId,
    required this.createdAt,
    required this.vouchers,
    required this.tokens,
    required this.currency,
  });

  // Factory method to parse JSON into ProfileData with validation
  factory ProfileData.fromJson(Map<String, dynamic> json) {
    if (json['uniqueId'] == null || json['created_at'] == null) {
      throw Exception('Dados de perfil inválidos: uniqueId ou createdAt ausente');
    }

    return ProfileData(
      uniqueId: json['uniqueId'],
      createdAt: DateTime.tryParse(json['created_at']) ?? DateTime.now(),
      vouchers: Vouchers.fromJson(json['vouchers'] ?? {}),
      tokens: Tokens.fromJson(json['tokens'] ?? {}),
      currency: Currency.fromJson(json['currency'] ?? {}),
    );
  }
}

class Vouchers {
  int valid;
  int invalid;
  int count;

  Vouchers({
    required this.valid,
    required this.invalid,
    required this.count,
  });

  // Factory method to parse JSON into Vouchers with number validation
  factory Vouchers.fromJson(Map<String, dynamic> json) {
    return Vouchers(
      valid: int.tryParse(json['valid']?.toString() ?? '0') ?? 0,
      invalid: int.tryParse(json['invalid']?.toString() ?? '0') ?? 0,
      count: int.tryParse(json['count']?.toString() ?? '0') ?? 0,
    );
  }
}

class Tokens {
  String amount;
  double collected;

  Tokens({
    required this.amount,
    required this.collected,
  });

  // Factory method to parse JSON into Tokens with number validation
  factory Tokens.fromJson(Map<String, dynamic> json) {
    return Tokens(
      // amount: double.tryParse(json['amount']?.toString() ?? '0.0') ?? 0.0,
      amount: json['amount'] ?? '0.0' ?? '0.0',
      collected: double.tryParse(json['collected']?.toString() ?? '0.0') ?? 0.0,
    );
  }
}

class Currency {
  String amount;

  Currency({
    required this.amount,
  });

  // Factory method to parse JSON into Currency with number validation
  factory Currency.fromJson(Map<String, dynamic> json) {
    print(json['amount']);
    return Currency(
        // json['amount']
      amount: json['amount'] ?? '0.0' ?? '0.0',
    );
  }
}

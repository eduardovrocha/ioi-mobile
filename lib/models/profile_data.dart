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

  // Factory method to parse JSON into ProfileData
  factory ProfileData.fromJson(Map<String, dynamic> json) {

    return ProfileData(
      uniqueId: json['uniqueId'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? ''),
      vouchers: Vouchers.fromJson(json['vouchers'] ?? ''),
      tokens: Tokens.fromJson(json['tokens'] ?? ''),
      currency: Currency.fromJson(json['currency'] ?? ''),
    );
  }
}

class Vouchers {
  String valid;
  String invalid;
  String count;

  Vouchers({
    required this.valid,
    required this.invalid,
    required this.count,
  });

  // Factory method to parse JSON into Vouchers
  factory Vouchers.fromJson(Map<String, dynamic> json) {
    return Vouchers(
      valid: json['valid'] ?? '',
      invalid: json['invalid'] ?? '',
      count: json['count'] ?? '',
    );
  }
}

class Tokens {
  String amount;
  String collected;

  Tokens({
    required this.amount,
    required this.collected,
  });

  // Factory method to parse JSON into Tokens
  factory Tokens.fromJson(Map<String, dynamic> json) {
    return Tokens(
      amount: json['amount'] ?? '',
      collected: json['collected'] ?? '',
    );
  }
}

class Currency {
  String amount;

  Currency({
    required this.amount,
  });

  // Factory method to parse JSON into Currency
  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      amount: json['amount'] ?? '',
    );
  }
}

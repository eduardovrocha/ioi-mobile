class ProfileData {
  String uniqueId;
  String createdAt;
  Vouchers vouchers;
  Presences presences;
  Tokens tokens;
  Currency currency;

  ProfileData({
    required this.uniqueId,
    required this.createdAt,
    required this.vouchers,
    required this.presences,
    required this.tokens,
    required this.currency,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      uniqueId: json['uniqueId']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      vouchers: Vouchers.fromJson(json['vouchers'] ?? {}),
      tokens: Tokens.fromJson(json['tokens'] ?? {}),
      currency: Currency.fromJson(json['currency'] ?? {}),
      presences: Presences.fromJson(json['presences'] ?? {}),
    );
  }

  void printProfileData() {}
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

  factory Vouchers.fromJson(Map<String, dynamic> json) {
    return Vouchers(
      valid: json['valid']?.toString() ?? '0',
      invalid: json['invalid']?.toString() ?? '0',
      count: json['count']?.toString() ?? '0',
    );
  }

  void printVouchers() {
    print('  Valid: $valid');
    print('  Invalid: $invalid');
    print('  Count: $count');
  }
}

class Presences {
  Map<String, dynamic> professional;
  Map<String, dynamic> personal;

  Presences({
    required this.professional,
    required this.personal,
  });

  factory Presences.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> professionalPresence = {};
    if (json['professional'] != null && json['professional'] is Map) {
      Map<String, dynamic> activation = json['professional']['activation'] ?? {};
      professionalPresence = {
        'doc': json['professional']['doc']?.toString() ?? '',
        'doc_type': json['professional']['doc_type']?.toString() ?? '',
        'activation': {
          'key': activation['key']?.toString() ?? '',
          'status': activation['status']?.toString() ?? '',
          'created_at': activation['created_at']?.toString() ?? '',
        }
      };
    }

    Map<String, dynamic> personalPresence = {};
    if (json['personal'] != null && json['personal'] is Map) {
      Map<String, dynamic> activation = json['personal']['activation'] ?? {};
      personalPresence = {
        'doc': json['personal']['doc']?.toString() ?? '',
        'doc_type': json['personal']['doc_type']?.toString() ?? '',
        'activation': {
          'key': activation['key']?.toString() ?? '',
          'status': activation['status']?.toString() ?? '',
          'created_at': activation['created_at']?.toString() ?? '',
        }
      };
    }

    return Presences(
      professional: professionalPresence,
      personal: personalPresence,
    );
  }

  void printPresences() {
    print("Professional Presence:");
    print("  Doc: ${professional['doc']}");
    print("  Doc Type: ${professional['doc_type']}");
    print("  Activation Key: ${professional['activation']['key']}");
    print("  Activation Status: ${professional['activation']['status']}");
    print("  Created At: ${professional['activation']['created_at']}");

    print("\nPersonal Presence:");
    print("  Doc: ${personal['doc']}");
    print("  Doc Type: ${personal['doc_type']}");
    print("  Activation Key: ${personal['activation']['key']}");
    print("  Activation Status: ${personal['activation']['status']}");
    print("  Created At: ${personal['activation']['created_at']}");
  }
}

class Tokens {
  String amount;
  String collected;
  String allocated;

  Tokens({
    required this.amount,
    required this.collected,
    required this.allocated,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) {
    return Tokens(
      amount: json['amount']?.toString() ?? '0.0',
      collected: json['collected']?.toString() ?? '0.0',
      allocated: json['allocated']?.toString() ?? '0.0',
    );
  }

  void printTokens() {
    print('  Amount: $amount');
    print('  Collected: $collected');
    print('  Allocated: $allocated');
  }
}

class Currency {
  String amount;

  Currency({
    required this.amount,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      amount: json['amount']?.toString() ?? '0.0',
    );
  }

  void printCurrency() {
    print('  Amount: $amount');
  }
}

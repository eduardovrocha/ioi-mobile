class CollectListItemData {
  final String shopName;
  final double dataHealthDeb;
  final double emptyPercentage;
  final String currencyAmount;
  final String tokenAmount;
  final String categoryNumber;

  CollectListItemData({
    required this.shopName,
    required this.dataHealthDeb,
    required this.emptyPercentage,
    required this.currencyAmount,
    required this.tokenAmount,
    required this.categoryNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      "shopName": shopName,
      "dataHealthDeb": dataHealthDeb,
      "emptyPercentage": emptyPercentage,
      "currencyAmount": currencyAmount,
      "tokenAmount": tokenAmount,
      "categoryNumber": categoryNumber,
    };
  }

  factory CollectListItemData.fromJson(Map<String, dynamic> json) {
    return CollectListItemData(
      shopName: json['shopName'] as String,
      dataHealthDeb: json['dataHealthDeb'] as double,
      emptyPercentage: json['emptyPercentage'] as double,
      currencyAmount: json['currencyAmount'] as String,
      tokenAmount: json['tokenAmount'] as String,
      categoryNumber: json['categoryNumber'] as String,
    );
  }
}

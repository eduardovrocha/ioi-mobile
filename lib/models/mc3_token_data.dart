class MC3TokenData {
  final String name;
  final String symbol;
  final int totalSupply;
  final String contractAddress;
  final double pricePerEth;
  final Map<String, double> allocations;

  MC3TokenData({
    required this.name,
    required this.symbol,
    required this.totalSupply,
    required this.contractAddress,
    required this.pricePerEth,
    required this.allocations,
  });

  factory MC3TokenData.defaultToken() {
    return MC3TokenData(
      name: "Mr. Cat Cash Coin",
      symbol: "MC3",
      totalSupply: 1000000000,
      contractAddress: "0xecacfd6d82e8f7c150dd545ea9cdff392d097f7e",
      pricePerEth: 1000,
      allocations: {
        "Pre Sale": 20.0,
        "Staking": 30.0,
        "Liquidity": 30.0,
        "Marketing": 5.0,
        "Tech Grow": 15.0,
      },
    );
  }

  // Method to convert to JSON
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "symbol": symbol,
      "totalSupply": totalSupply,
      "contractAddress": contractAddress,
      "pricePerEth": pricePerEth,
      "allocations": allocations,
    };
  }

  // Method to create a model from JSON
  factory MC3TokenData.fromJson(Map<String, dynamic> json) {
    return MC3TokenData(
      name: json['name'],
      symbol: json['symbol'],
      totalSupply: json['totalSupply'],
      contractAddress: json['contractAddress'],
      pricePerEth: json['pricePerEth'],
      allocations: Map<String, double>.from(json['allocations']),
    );
  }
}

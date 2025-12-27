class Stock {
  final String symbol;
  final String company;
  final double price;
  final double change;
  final double changePercent;
  final int volume;
  final double marketCap;

  Stock({
    required this.symbol,
    required this.company,
    required this.price,
    required this.change,
    required this.changePercent,
    required this.volume,
    required this.marketCap,
  });

  //Factory constructor to create a stock instance from json dummy data
  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      symbol: json['symbol'] as String,
      company: json['company'] as String,
      price: (json['price'] as num).toDouble(),
      change: (json['change'] as num).toDouble(),
      changePercent: (json['changePercent'] as num).toDouble(),
      volume: (json['volume'] as num).toInt(),
      marketCap: (json['marketCap'] as num).toDouble(),
    );
  }
}

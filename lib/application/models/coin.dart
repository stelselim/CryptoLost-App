class Coin {
  String id;
  String symbol;
  String name;
  CoinImage image;
  CoinMarketData market_data;
  String last_updated;
  Coin({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.market_data,
    required this.last_updated,
  });
}

class CoinImage {
  String thumb;
  String small;
  String large;
  CoinImage({
    required this.thumb,
    required this.small,
    required this.large,
  });
}

class CoinMarketData {
  Map<String, double> current_price;
  Map<String, double> market_cap;
  int market_cap_rank;
  double price_change_24h;
  double price_change_percentage_24h;
  double price_change_percentage_7d;
  double price_change_percentage_30d;
  double price_change_percentage_200d;
  double market_cap_change_24h;
  CoinMarketData({
    required this.current_price,
    required this.market_cap,
    required this.market_cap_rank,
    required this.price_change_24h,
    required this.price_change_percentage_24h,
    required this.price_change_percentage_7d,
    required this.price_change_percentage_30d,
    required this.price_change_percentage_200d,
    required this.market_cap_change_24h,
  });
}

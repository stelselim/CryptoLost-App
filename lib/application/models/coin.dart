import 'dart:convert';

import 'package:flutter/foundation.dart';

class CoinModel {
  String? id;
  String? symbol;
  String? name;
  CoinImage? image;
  CoinMarketData? market_data;
  String? last_updated;
  CoinModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.market_data,
    required this.last_updated,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'symbol': symbol,
      'name': name,
      'image': image?.toMap(),
      'market_data': market_data?.toMap(),
      'last_updated': last_updated,
    };
  }

  factory CoinModel.fromMap(Map<String, dynamic> map) {
    return CoinModel(
      id: map['id'],
      symbol: map['symbol'],
      name: map['name'],
      image: CoinImage.fromMap(map['image']),
      market_data: CoinMarketData.fromMap(map['market_data']),
      last_updated: map['last_updated'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CoinModel.fromJson(String source) =>
      CoinModel.fromMap(json.decode(source));

  CoinModel copyWith({
    String? id,
    String? symbol,
    String? name,
    CoinImage? image,
    CoinMarketData? market_data,
    String? last_updated,
  }) {
    return CoinModel(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      image: image ?? this.image,
      market_data: market_data ?? this.market_data,
      last_updated: last_updated ?? this.last_updated,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CoinModel &&
        other.id == id &&
        other.symbol == symbol &&
        other.name == name &&
        other.image == image &&
        other.market_data == market_data &&
        other.last_updated == last_updated;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        symbol.hashCode ^
        name.hashCode ^
        image.hashCode ^
        market_data.hashCode ^
        last_updated.hashCode;
  }

  @override
  String toString() {
    return 'CoinModel(id: $id, symbol: $symbol, name: $name, image: $image, market_data: $market_data, last_updated: $last_updated)';
  }
}

class CoinImage {
  String? thumb;
  String? small;
  String? large;
  CoinImage({
    required this.thumb,
    required this.small,
    required this.large,
  });

  CoinImage copyWith({
    String? thumb,
    String? small,
    String? large,
  }) {
    return CoinImage(
      thumb: thumb ?? this.thumb,
      small: small ?? this.small,
      large: large ?? this.large,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'thumb': thumb,
      'small': small,
      'large': large,
    };
  }

  factory CoinImage.fromMap(Map<String, dynamic> map) {
    return CoinImage(
      thumb: map['thumb'],
      small: map['small'],
      large: map['large'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CoinImage.fromJson(String source) =>
      CoinImage.fromMap(json.decode(source));

  @override
  String toString() => 'CoinImage(thumb: $thumb, small: $small, large: $large)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CoinImage &&
        other.thumb == thumb &&
        other.small == small &&
        other.large == large;
  }

  @override
  int get hashCode => thumb.hashCode ^ small.hashCode ^ large.hashCode;
}

class CoinMarketData {
  Map<String, num>? current_price;
  Map<String, num>? market_cap;
  int? market_cap_rank;
  num? price_change_24h;
  num? price_change_percentage_24h;
  num? price_change_percentage_7d;
  num? price_change_percentage_30d;
  num? price_change_percentage_200d;
  num? market_cap_change_24h;
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

  CoinMarketData copyWith({
    Map<String, num>? current_price,
    Map<String, num>? market_cap,
    int? market_cap_rank,
    num? price_change_24h,
    num? price_change_percentage_24h,
    num? price_change_percentage_7d,
    num? price_change_percentage_30d,
    num? price_change_percentage_200d,
    num? market_cap_change_24h,
  }) {
    return CoinMarketData(
      current_price: current_price ?? this.current_price,
      market_cap: market_cap ?? this.market_cap,
      market_cap_rank: market_cap_rank ?? this.market_cap_rank,
      price_change_24h: price_change_24h ?? this.price_change_24h,
      price_change_percentage_24h:
          price_change_percentage_24h ?? this.price_change_percentage_24h,
      price_change_percentage_7d:
          price_change_percentage_7d ?? this.price_change_percentage_7d,
      price_change_percentage_30d:
          price_change_percentage_30d ?? this.price_change_percentage_30d,
      price_change_percentage_200d:
          price_change_percentage_200d ?? this.price_change_percentage_200d,
      market_cap_change_24h:
          market_cap_change_24h ?? this.market_cap_change_24h,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'current_price': current_price,
      'market_cap': market_cap,
      'market_cap_rank': market_cap_rank,
      'price_change_24h': price_change_24h,
      'price_change_percentage_24h': price_change_percentage_24h,
      'price_change_percentage_7d': price_change_percentage_7d,
      'price_change_percentage_30d': price_change_percentage_30d,
      'price_change_percentage_200d': price_change_percentage_200d,
      'market_cap_change_24h': market_cap_change_24h,
    };
  }

  factory CoinMarketData.fromMap(Map<String, dynamic> map) {
    return CoinMarketData(
      current_price: Map<String, num>.from(map['current_price']),
      market_cap: Map<String, num>.from(map['market_cap']),
      market_cap_rank: map['market_cap_rank'],
      price_change_24h: map['price_change_24h'],
      price_change_percentage_24h: map['price_change_percentage_24h'],
      price_change_percentage_7d: map['price_change_percentage_7d'],
      price_change_percentage_30d: map['price_change_percentage_30d'],
      price_change_percentage_200d: map['price_change_percentage_200d'],
      market_cap_change_24h: map['market_cap_change_24h'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CoinMarketData.fromJson(String source) =>
      CoinMarketData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CoinMarketData(current_price: $current_price, market_cap: $market_cap, market_cap_rank: $market_cap_rank, price_change_24h: $price_change_24h, price_change_percentage_24h: $price_change_percentage_24h, price_change_percentage_7d: $price_change_percentage_7d, price_change_percentage_30d: $price_change_percentage_30d, price_change_percentage_200d: $price_change_percentage_200d, market_cap_change_24h: $market_cap_change_24h)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CoinMarketData &&
        mapEquals(other.current_price, current_price) &&
        mapEquals(other.market_cap, market_cap) &&
        other.market_cap_rank == market_cap_rank &&
        other.price_change_24h == price_change_24h &&
        other.price_change_percentage_24h == price_change_percentage_24h &&
        other.price_change_percentage_7d == price_change_percentage_7d &&
        other.price_change_percentage_30d == price_change_percentage_30d &&
        other.price_change_percentage_200d == price_change_percentage_200d &&
        other.market_cap_change_24h == market_cap_change_24h;
  }

  @override
  int get hashCode {
    return current_price.hashCode ^
        market_cap.hashCode ^
        market_cap_rank.hashCode ^
        price_change_24h.hashCode ^
        price_change_percentage_24h.hashCode ^
        price_change_percentage_7d.hashCode ^
        price_change_percentage_30d.hashCode ^
        price_change_percentage_200d.hashCode ^
        market_cap_change_24h.hashCode;
  }
}

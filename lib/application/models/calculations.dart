import 'dart:convert';

import 'package:cryptolostapp/application/models/coin.dart';

class Calculation {
  CoinModel coinModel;
  DateTime dateTime;
  bool isLoss;
  num profit;
  num percentage;
  Calculation({
    required this.coinModel,
    required this.dateTime,
    required this.isLoss,
    required this.profit,
    required this.percentage,
  });

  Map<String, dynamic> toMap() {
    return {
      'coinModel': coinModel.toMap(),
      'dateTime': dateTime.millisecondsSinceEpoch,
      'isLoss': isLoss,
      'profit': profit,
      'percentage': percentage,
    };
  }

  factory Calculation.fromMap(Map<String, dynamic> map) {
    return Calculation(
      coinModel: CoinModel.fromMap(map['coinModel']),
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
      isLoss: map['isLoss'],
      profit: map['profit'],
      percentage: map['percentage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Calculation.fromJson(String source) =>
      Calculation.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Calculation &&
        other.coinModel == coinModel &&
        other.dateTime == dateTime &&
        other.isLoss == isLoss &&
        other.profit == profit &&
        other.percentage == percentage;
  }

  @override
  int get hashCode {
    return coinModel.hashCode ^
        dateTime.hashCode ^
        isLoss.hashCode ^
        profit.hashCode ^
        percentage.hashCode;
  }

  @override
  String toString() {
    return 'Calculation(coinModel: $coinModel, dateTime: $dateTime, isLoss: $isLoss, profit: $profit, percentage: $percentage)';
  }

  Calculation copyWith({
    CoinModel? coinModel,
    DateTime? dateTime,
    bool? isLoss,
    num? profit,
    num? percentage,
  }) {
    return Calculation(
      coinModel: coinModel ?? this.coinModel,
      dateTime: dateTime ?? this.dateTime,
      isLoss: isLoss ?? this.isLoss,
      profit: profit ?? this.profit,
      percentage: percentage ?? this.percentage,
    );
  }
}

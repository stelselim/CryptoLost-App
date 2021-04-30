import 'dart:convert';

import 'package:cryptolostapp/application/models/coin.dart';

class Calculation {
  CoinModel coinModel;
  DateTime oldDateTime;
  DateTime currentDateTime;
  bool isLoss;
  num profit;
  num percentage;
  Calculation({
    required this.coinModel,
    required this.oldDateTime,
    required this.currentDateTime,
    required this.isLoss,
    required this.profit,
    required this.percentage,
  });

  Map<String, dynamic> toMap() {
    return {
      'coinModel': coinModel.toMap(),
      'oldDateTime': oldDateTime.millisecondsSinceEpoch,
      'currentDateTime': currentDateTime.millisecondsSinceEpoch,
      'isLoss': isLoss,
      'profit': profit,
      'percentage': percentage,
    };
  }

  factory Calculation.fromMap(Map<String, dynamic> map) {
    DateTime oldDateTime;
    DateTime currentDateTime;
    if (map.containsKey("dateTime")) {
      oldDateTime = DateTime.fromMillisecondsSinceEpoch(map['dateTime']);
      currentDateTime = DateTime.now();
    } else {
      oldDateTime = DateTime.fromMillisecondsSinceEpoch(map['oldDateTime']);
      currentDateTime =
          DateTime.fromMillisecondsSinceEpoch(map['currentDateTime']);
    }

    return Calculation(
      coinModel: CoinModel.fromMap(map['coinModel']),
      oldDateTime: oldDateTime,
      currentDateTime: currentDateTime,
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
        other.oldDateTime == oldDateTime &&
        other.currentDateTime == currentDateTime &&
        other.isLoss == isLoss &&
        other.profit == profit &&
        other.percentage == percentage;
  }

  @override
  int get hashCode {
    return coinModel.hashCode ^
        oldDateTime.hashCode ^
        currentDateTime.hashCode ^
        isLoss.hashCode ^
        profit.hashCode ^
        percentage.hashCode;
  }

  @override
  String toString() {
    return 'Calculation(coinModel: $coinModel, oldDateTime: $oldDateTime, currentDateTime: $currentDateTime, isLoss: $isLoss, profit: $profit, percentage: $percentage)';
  }

  Calculation copyWith({
    CoinModel? coinModel,
    DateTime? oldDateTime,
    DateTime? currentDateTime,
    bool? isLoss,
    num? profit,
    num? percentage,
  }) {
    return Calculation(
      coinModel: coinModel ?? this.coinModel,
      oldDateTime: oldDateTime ?? this.oldDateTime,
      currentDateTime: currentDateTime ?? this.currentDateTime,
      isLoss: isLoss ?? this.isLoss,
      profit: profit ?? this.profit,
      percentage: percentage ?? this.percentage,
    );
  }
}

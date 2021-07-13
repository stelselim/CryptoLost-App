import 'dart:convert';

import 'package:cryptolostapp/application/models/coin.dart';

class HistoryCalculation {
  CoinModel coinModel;
  CoinModel oldCoinModel;
  DateTime oldDateTime;
  DateTime currentDateTime;
  bool isLoss;
  num profit;
  num percentage;
  HistoryCalculation({
    required this.coinModel,
    required this.oldCoinModel,
    required this.oldDateTime,
    required this.currentDateTime,
    required this.isLoss,
    required this.profit,
    required this.percentage,
  });

  Map<String, dynamic> toMap() {
    return {
      'coinModel': coinModel.toMap(),
      'oldCoinModel': oldCoinModel.toMap(),
      'oldDateTime': oldDateTime.millisecondsSinceEpoch,
      'currentDateTime': currentDateTime.millisecondsSinceEpoch,
      'isLoss': isLoss,
      'profit': profit,
      'percentage': percentage,
    };
  }

  factory HistoryCalculation.fromMap(Map<String, dynamic> map) {
    return HistoryCalculation(
      coinModel: CoinModel.fromMap(map['coinModel']),
      oldCoinModel: CoinModel.fromMap(map['oldCoinModel']),
      oldDateTime: DateTime.fromMillisecondsSinceEpoch(map['oldDateTime']),
      currentDateTime:
          DateTime.fromMillisecondsSinceEpoch(map['currentDateTime']),
      isLoss: map['isLoss'],
      profit: map['profit'],
      percentage: map['percentage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryCalculation.fromJson(String source) =>
      HistoryCalculation.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HistoryCalculation &&
        other.coinModel == coinModel &&
        other.oldCoinModel == oldCoinModel &&
        other.oldDateTime == oldDateTime &&
        other.currentDateTime == currentDateTime &&
        other.isLoss == isLoss &&
        other.profit == profit &&
        other.percentage == percentage;
  }

  @override
  int get hashCode {
    return coinModel.hashCode ^
        oldCoinModel.hashCode ^
        oldDateTime.hashCode ^
        currentDateTime.hashCode ^
        isLoss.hashCode ^
        profit.hashCode ^
        percentage.hashCode;
  }

  @override
  String toString() {
    return 'HistoryCalculation(coinModel: $coinModel, oldCoinModel: $oldCoinModel, oldDateTime: $oldDateTime, currentDateTime: $currentDateTime, isLoss: $isLoss, profit: $profit, percentage: $percentage)';
  }

  HistoryCalculation copyWith({
    CoinModel? coinModel,
    CoinModel? oldCoinModel,
    DateTime? oldDateTime,
    DateTime? currentDateTime,
    bool? isLoss,
    num? profit,
    num? percentage,
  }) {
    return HistoryCalculation(
      coinModel: coinModel ?? this.coinModel,
      oldCoinModel: oldCoinModel ?? this.oldCoinModel,
      oldDateTime: oldDateTime ?? this.oldDateTime,
      currentDateTime: currentDateTime ?? this.currentDateTime,
      isLoss: isLoss ?? this.isLoss,
      profit: profit ?? this.profit,
      percentage: percentage ?? this.percentage,
    );
  }
}

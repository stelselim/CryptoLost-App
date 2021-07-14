import 'package:cryptolostapp/application/models/coin_model.dart';

// For Coin Comparison List Widget
class CoinComparisonClass {
  CoinModel historyOfCoin; // Resulted Value
  CoinModel currentResultCoin; // Resulted Value
  DateTime historyOfDate; // Resulted Date
  num resultCoinAmount; // Result Amount
  CoinComparisonClass({
    required this.historyOfCoin,
    required this.currentResultCoin,
    required this.historyOfDate,
    required this.resultCoinAmount,
  });
}

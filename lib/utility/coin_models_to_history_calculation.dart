import 'package:cryptolostapp/application/models/coin_model.dart';
import 'package:cryptolostapp/application/models/history_calculations.dart';

HistoryCalculation coinModelsToHistoryCalculation(
  CoinModel currentCoin,
  CoinModel historyOfCoin,
  DateTime historyDate,
  num amount,
) {
  final _history = historyOfCoin.market_data!.current_price!["usd"]!;
  final _current = currentCoin.market_data!.current_price!["usd"]!;
  final _ratio = 100 * (_current - _history) / _history;

  return HistoryCalculation(
    oldCoinModel: historyOfCoin,
    coinModel: currentCoin,
    currentDateTime: DateTime.now(),
    oldDateTime: historyDate,
    isLoss: _history > _current,
    profit: amount * (_history - _current).abs(),
    percentage: _ratio.abs(),
  );
}

import 'package:cryptolostapp/application/models/coin.dart';
import 'package:cryptolostapp/application/models/portfolio_calculations.dart';

PorfolioCalculation coinModelsToPortfolioCalculation(
  CoinModel currentCoin,
  CoinModel historyOfCoin,
  DateTime historyDate,
) {
  final _history = historyOfCoin.market_data!.current_price!["usd"]!;
  final _current = currentCoin.market_data!.current_price!["usd"]!;
  final _ratio = 100 * (_current - _history) / _history;

  return PorfolioCalculation(
    coinModel: currentCoin,
    currentDateTime: DateTime.now(),
    oldDateTime: historyDate,
    isLoss: _history > _current,
    profit: (_history - _current).abs(),
    percentage: _ratio.abs(),
  );
}

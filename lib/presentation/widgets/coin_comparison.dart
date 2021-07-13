import 'package:cryptolostapp/application/classes/coin_comparison_class.dart';
import 'package:cryptolostapp/application/models/calculations.dart';
import 'package:cryptolostapp/application/models/coin.dart';
import 'package:cryptolostapp/utility/save_calculation.dart';
import 'package:cryptolostapp/utility/share_calculation.dart';
import 'package:flutter/material.dart';
import 'package:cryptolostapp/utility/analytics/google_anayltics_functions.dart';
import 'package:intl/intl.dart';

class CoinComparisonList extends StatelessWidget {
  final CoinComparisonClass coinComparison;

  const CoinComparisonList({
    Key? key,
    required this.coinComparison,
  }) : super(key: key);

  Widget findRatio() {
    final CoinModel currentCoin = coinComparison.currentResultCoin.copyWith();
    final CoinModel historyOfCoin = coinComparison.historyOfCoin.copyWith();

    final _history = historyOfCoin.market_data!.current_price!["usd"]!;
    final _current = currentCoin.market_data!.current_price!["usd"]!;

    if (_history > _current) {
      final _ratio = 100 * (_current - _history) / _history;

      return Column(
        children: [
          Text(
            "- %${_ratio.abs().toStringAsFixed(2)} 🙁",
            textScaleFactor: 3.25,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    } else {
      final _ratio = 100 * (_current - _history) / _history;
      return Column(
        children: [
          Text(
            "%${_ratio.toStringAsFixed(2)} 🤤🤑",
            textScaleFactor: 3.25,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.blue,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
  }

  Widget profitWidget() {
    final num coinAmount = coinComparison.resultCoinAmount;
    final CoinModel currentCoin = coinComparison.currentResultCoin.copyWith();
    final CoinModel historyOfCoin = coinComparison.historyOfCoin.copyWith();

    final _history = historyOfCoin.market_data!.current_price!["usd"]!;
    final _current = currentCoin.market_data!.current_price!["usd"]!;

    if (_history < _current) {
      final profit = ((_current - _history) * coinAmount).toStringAsFixed(2);

      return Column(
        children: [
          Text(
            "Your Profit is $profit USD",
            textScaleFactor: 1.5,
            style: const TextStyle(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      );
    } else {
      final loss =
          ((_current - _history) * coinAmount).abs().toStringAsFixed(2);
      return Column(
        children: [
          Text(
            "Your Loss is $loss USD",
            textScaleFactor: 1.5,
            style: const TextStyle(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
  }

  Future saveTheCalculations() async {
    final CoinModel currentCoin = coinComparison.currentResultCoin.copyWith();
    final CoinModel historyOfCoin = coinComparison.historyOfCoin.copyWith();
    final DateTime historyDate = coinComparison.historyOfDate;

    try {
      final _history = historyOfCoin.market_data!.current_price!["usd"]!;
      final _current = currentCoin.market_data!.current_price!["usd"]!;
      final _ratio = 100 * (_current - _history) / _history;

      final toSaveCalculation = Calculation(
        coinModel: currentCoin,
        currentDateTime: DateTime.now(),
        oldDateTime: historyDate,
        isLoss: _history > _current,
        profit: (_history - _current).abs(),
        percentage: _ratio.abs(),
      );
      await saveNewCalculation(toSaveCalculation);
      await savedCalculationEvent();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final num coinAmount = coinComparison.resultCoinAmount;
    final CoinModel currentCoin = coinComparison.currentResultCoin.copyWith();
    final CoinModel historyOfCoin = coinComparison.historyOfCoin.copyWith();
    final DateTime historyDate = coinComparison.historyOfDate;

    final history = historyOfCoin.market_data!.current_price!["usd"]!;
    final current = currentCoin.market_data!.current_price!["usd"]!;
    final ratio = 100 * (current - history) / history;

    final profit = (currentCoin.market_data!.current_price!["usd"]! -
            currentCoin.market_data!.current_price!["usd"]!)
        .abs();

    final String historyMoney = NumberFormat.currency(name: "")
        .format(historyOfCoin.market_data!.current_price!["usd"]! * coinAmount);

    final String currentMoney = NumberFormat.currency(name: "")
        .format(currentCoin.market_data!.current_price!["usd"]! * coinAmount);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(
                Icons.share,
                color: Colors.indigo,
                size: 32,
              ),
              onPressed: () async {
                try {
                  await shareCalculation(
                    Calculation(
                      oldDateTime: historyDate,
                      coinModel: currentCoin,
                      currentDateTime: DateTime.now(),
                      isLoss:
                          historyOfCoin.market_data!.current_price!["usd"]! >
                              currentCoin.market_data!.current_price!["usd"]!,
                      profit: profit,
                      percentage: ratio,
                    ),
                  );
                } catch (e) {
                  print(e);
                }
              },
            ),
            const SizedBox(
              width: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                onPressed: () => saveTheCalculations(),
                child: const Text(
                  "Save This!",
                  textScaleFactor: 1.25,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: profitWidget(),
        ),
        ListTile(
          leading: Image.network(historyOfCoin.image!.thumb!),
          subtitle:
              Text("History - ${DateFormat('MM-dd-yyyy').format(historyDate)}"),
          title: Text(historyOfCoin.name!),
          trailing: Text(
            historyOfCoin.market_data!.current_price!["usd"]!
                .toStringAsFixed(2),
          ),
        ),
        ListTile(
          leading: Image.network(currentCoin.image!.thumb!),
          subtitle: Text(
              "Today - ${DateFormat('MM-dd-yyyy').format(DateTime.now())}"),
          title: Text(currentCoin.name!),
          trailing: Text(
            currentCoin.market_data!.current_price!["usd"]!.toStringAsFixed(2),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Your money was $historyMoney USD",
            textScaleFactor: 1.5,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Your money is $currentMoney USD",
            textScaleFactor: 1.5,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.blue,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(padding: const EdgeInsets.all(8.0), child: findRatio()),
      ],
    );
  }
}

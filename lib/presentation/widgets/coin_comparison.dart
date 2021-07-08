import 'package:cryptolostapp/application/classes/coinComparisonClass.dart';
import 'package:cryptolostapp/application/models/calculations.dart';
import 'package:cryptolostapp/application/models/coin.dart';
import 'package:cryptolostapp/utility/analytics/google_anayltics_functions.dart';
import 'package:cryptolostapp/utility/save_calculation.dart';
import 'package:cryptolostapp/utility/share_calculation.dart';
import 'package:flutter/material.dart';
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

    var _history = historyOfCoin.market_data!.current_price!["usd"]!;
    var _current = currentCoin.market_data!.current_price!["usd"]!;

    if (_history > _current) {
      var _ratio = 100 * (_current - _history) / _history;

      return Column(
        children: [
          Text(
            "- %${_ratio.abs().toStringAsFixed(2)} 🙁",
            textScaleFactor: 3.25,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      );
    } else {
      var _ratio = 100 * (_current - _history) / _history;
      print(_ratio);
      return Column(
        children: [
          Text(
            "%${_ratio.toStringAsFixed(2)} 🤤🤑",
            textScaleFactor: 3.25,
            style: TextStyle(
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

    var _history = historyOfCoin.market_data!.current_price!["usd"]!;
    var _current = currentCoin.market_data!.current_price!["usd"]!;

    if (_history < _current) {
      var profit = ((_current - _history) * coinAmount).toStringAsFixed(2);

      return Column(
        children: [
          Text(
            "Your Profit is $profit USD",
            textScaleFactor: 1.5,
            style: TextStyle(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      );
    } else {
      var loss = ((_current - _history) * coinAmount).abs().toStringAsFixed(2);
      return Column(
        children: [
          Text(
            "Your Loss is $loss USD",
            textScaleFactor: 1.5,
            style: TextStyle(fontWeight: FontWeight.w600),
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
      var _history = historyOfCoin.market_data!.current_price!["usd"]!;
      var _current = currentCoin.market_data!.current_price!["usd"]!;
      var _ratio = 100 * (_current - _history) / _history;

      var toSaveCalculation = Calculation(
        coinModel: currentCoin,
        currentDateTime: DateTime.now(),
        oldDateTime: historyDate,
        isLoss: _history > _current ? true : false,
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

    var history = historyOfCoin.market_data!.current_price!["usd"]!;
    var current = currentCoin.market_data!.current_price!["usd"]!;
    var ratio = 100 * (current - history) / history;

    var profit = (currentCoin.market_data!.current_price!["usd"]! -
            currentCoin.market_data!.current_price!["usd"]!)
        .abs();

    String historyMoney = NumberFormat.currency(name: "")
        .format(historyOfCoin.market_data!.current_price!["usd"]! * coinAmount);

    String currentMoney = NumberFormat.currency(name: "")
        .format(currentCoin.market_data!.current_price!["usd"]! * coinAmount);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(
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
                        isLoss: historyOfCoin
                                    .market_data!.current_price!["usd"]! >
                                currentCoin.market_data!.current_price!["usd"]!
                            ? true
                            : false,
                        profit: profit,
                        percentage: ratio,
                      ),
                    );
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              SizedBox(
                width: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                  onPressed: () => saveTheCalculations(),
                  child: Text(
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
            subtitle: Text(
                "History - " + DateFormat('MM-dd-yyyy').format(historyDate)),
            title: Text(historyOfCoin.name!),
            trailing: Text(
              historyOfCoin.market_data!.current_price!["usd"]!
                  .toStringAsFixed(2),
            ),
          ),
          ListTile(
            leading: Image.network(currentCoin.image!.thumb!),
            subtitle: Text(
                "Today - " + DateFormat('MM-dd-yyyy').format(DateTime.now())),
            title: Text(currentCoin.name!),
            trailing: Text(
              currentCoin.market_data!.current_price!["usd"]!
                  .toStringAsFixed(2),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Your money was $historyMoney USD",
              textScaleFactor: 1.5,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Your money is $currentMoney USD",
              textScaleFactor: 1.5,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(padding: const EdgeInsets.all(8.0), child: findRatio()),
        ],
      ),
    );
  }
}

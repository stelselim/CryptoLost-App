import 'package:cryptolostapp/application/models/coin.dart';
import 'package:cryptolostapp/application/models/history_calculations.dart';
import 'package:cryptolostapp/application/models/portfolio_calculations.dart';
import 'package:cryptolostapp/infrastructure/calculation/save_calculation.dart';
import 'package:cryptolostapp/utility/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HistoryCoinWidget extends StatelessWidget {
  final HistoryCalculation historyCalculation;
  final void Function() deleteHistoryCalculation;
  const HistoryCoinWidget({
    Key? key,
    required this.historyCalculation,
    required this.deleteHistoryCalculation,
  }) : super(key: key);

  static const dateScaleFactor = 1.10;

  Widget findRatio(CoinModel currentCoin, CoinModel historyOfCoin) {
    const textScaleFactor = 2.25;
    final _history = historyOfCoin.market_data!.current_price!["usd"]!;
    final _current = currentCoin.market_data!.current_price!["usd"]!;

    if (_history > _current) {
      final _ratio = 100 * (_current - _history) / _history;

      return Column(
        children: [
          Text(
            "- %${_ratio.abs().toStringAsFixed(2)} 🙁",
            textScaleFactor: textScaleFactor,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.red,
            ),
            textAlign: TextAlign.end,
          ),
        ],
      );
    } else {
      final _ratio = 100 * (_current - _history) / _history;

      return Column(
        children: [
          Text(
            "%${_ratio.toStringAsFixed(2)} 🤤🤑",
            textScaleFactor: textScaleFactor,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.blue,
            ),
            textAlign: TextAlign.end,
          ),
        ],
      );
    }
  }

  Widget profitWidget({required num profit, required bool isLoss}) {
    if (!isLoss) {
      return Column(
        children: [
          Text(
            "Your Profit is ${profit.toStringAsFixed(2)} USD",
            textScaleFactor: 1.5,
            style: const TextStyle(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Text(
            "Your Loss is ${profit.toStringAsFixed(2)} USD",
            textScaleFactor: 1.5,
            style: const TextStyle(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        final AlertDialog alert = AlertDialog(
          title: const Text("History Operations"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close"),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await saveNewPortfolioCalculations(PorfolioCalculation(
                    coinModel: historyCalculation.coinModel,
                    currentDateTime: historyCalculation.currentDateTime,
                    isLoss: historyCalculation.isLoss,
                    profit: historyCalculation.percentage,
                    percentage: historyCalculation.percentage,
                    oldDateTime: historyCalculation.oldDateTime,
                  ));
                  Navigator.pop(context);
                  Fluttertoast.showToast(msg: "Calculation Saved!");
                } catch (e) {
                  print(e);
                }
              },
              child: const Text("Save To Portfolio"),
            ),
            TextButton(
              onPressed: deleteHistoryCalculation,
              child: const Text("Delete Calculation"),
            ),
          ],
        );
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.32,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Dates
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "History: ${formatDate(historyCalculation.oldDateTime)}",
                        textScaleFactor: dateScaleFactor,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Today: ${formatDate(historyCalculation.currentDateTime)}",
                        textScaleFactor: dateScaleFactor,
                      ),
                    ],
                  ),
                  // Prices
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price: ${historyCalculation.coinModel.market_data!.current_price!['usd']!.toStringAsFixed(2)} \$",
                        textScaleFactor: dateScaleFactor,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Price: ${historyCalculation.oldCoinModel.market_data!.current_price!['usd']!.toStringAsFixed(2)} \$",
                        textScaleFactor: dateScaleFactor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(
                    historyCalculation.coinModel.image!.large!,
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  Text(
                      "${historyCalculation.coinModel.name!} (${historyCalculation.coinModel.symbol!.toUpperCase()})"),
                  Text(historyCalculation.coinModel.name!),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    findRatio(
                      historyCalculation.coinModel,
                      historyCalculation.oldCoinModel,
                    ),
                    profitWidget(
                      profit: historyCalculation.profit,
                      isLoss: historyCalculation.isLoss,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

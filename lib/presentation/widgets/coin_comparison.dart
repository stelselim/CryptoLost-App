import 'package:cryptolostapp/application/models/coin.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CoinComparisonList extends StatelessWidget {
  final CoinModel? currentCoin;
  final num? coinAmount;
  final CoinModel? historyOfCoin;
  final DateTime? historyDate;

  const CoinComparisonList({
    Key? key,
    @required this.currentCoin,
    @required this.historyOfCoin,
    @required this.historyDate,
    this.coinAmount,
  }) : super(key: key);

  Widget findRatio() {
    var _history = historyOfCoin!.market_data!.current_price!["usd"]!;
    var _current = currentCoin!.market_data!.current_price!["usd"]!;

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

  @override
  Widget build(BuildContext context) {
    final currentMoney =
        (currentCoin!.market_data!.current_price!["usd"]! * coinAmount!)
            .toStringAsFixed(2);
    final historyMoney =
        (historyOfCoin!.market_data!.current_price!["usd"]! * coinAmount!)
            .toStringAsFixed(2);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Now 1 ${currentCoin!.name} is ${currentCoin!.market_data!.current_price!["usd"]}",
              textScaleFactor: 1.5,
              style: TextStyle(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
          ListTile(
            leading: Image.network(currentCoin!.image!.thumb!),
            subtitle: Text(
                "Now - " + DateFormat('MM-dd-yyyy').format(DateTime.now())),
            title: Text(currentCoin!.name!),
            trailing: Text(
              currentCoin!.market_data!.current_price!["usd"]!
                  .toStringAsFixed(2),
            ),
          ),
          ListTile(
            leading: Image.network(historyOfCoin!.image!.thumb!),
            subtitle: Text(
                "History - " + DateFormat('MM-dd-yyyy').format(historyDate!)),
            title: Text(historyOfCoin!.name!),
            trailing: Text(
              historyOfCoin!.market_data!.current_price!["usd"]!
                  .toStringAsFixed(2),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Your Money was $historyMoney",
              textScaleFactor: 1.75,
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
              "Your Money is $currentMoney",
              textScaleFactor: 1.75,
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

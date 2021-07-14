import 'package:cryptolostapp/application/models/portfolio_calculations.dart';
import 'package:cryptolostapp/utility/currency_formatter.dart';
import "package:flutter/material.dart";

class TotalCalculations extends StatelessWidget {
  final List<PorfolioCalculation>? calculations;
  static num totalMoney = 0;
  const TotalCalculations({Key? key, this.calculations}) : super(key: key);

  String findTotal() {
    totalMoney = 0;
    calculations!.forEach((element) {
      totalMoney += element.profit;
    });
    return formatMoney(totalMoney);
  }

  @override
  Widget build(BuildContext context) {
    final String total = findTotal();

    return Container(
      color: Colors.blueGrey.shade100,
      margin: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: MediaQuery.of(context).size.width * 0.2,
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.6,
            child: Text(
              totalMoney > 0
                  ? "Total Profit: \$$total"
                  : "Total Loss: \$$total",
              textScaleFactor: 2.0,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.blueGrey.shade900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

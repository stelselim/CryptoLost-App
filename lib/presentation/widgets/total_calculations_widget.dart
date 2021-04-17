import 'package:cryptolostapp/application/models/calculations.dart';
import 'package:cryptolostapp/utility/currencyFormatter.dart';
import 'package:flutter/material.dart';

class TotalCalculations extends StatelessWidget {
  final List<Calculation>? calculations;
  static num totalMoney = 0;
  const TotalCalculations({Key? key, this.calculations}) : super(key: key);

  findTotal() {
    totalMoney = 0;
    calculations!.forEach((element) {
      totalMoney += element.profit;
    });
    return formatMoney(totalMoney);
  }

  @override
  Widget build(BuildContext context) {
    String total = findTotal();

    return Container(
      color: Colors.blueGrey.shade100,
      margin: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: MediaQuery.of(context).size.width * 0.2,
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Text(
              totalMoney > 0 ? "Total Profit: $total" : "Total Loss: $total",
              textScaleFactor: 2.25,
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

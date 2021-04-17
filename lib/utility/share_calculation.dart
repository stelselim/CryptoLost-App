import 'package:cryptolostapp/application/models/calculations.dart';
import 'package:share/share.dart';

Future<void> shareCalculation(Calculation calculation) async {
  final profit = calculation.profit.toStringAsFixed(2);
  final percentage = calculation.percentage.toStringAsFixed(2);
  final coin = calculation.coinModel;
  var shareText = "";
  if (calculation.isLoss) {
    shareText =
        "You loss %$percentage by ${coin.name}. The profit is $profit 🙁😞. \n\nThis is calculated by Crypto Loss/Gain Calculator.";
  } else {
    shareText =
        "You gained %$percentage by ${coin.name}. The profit is $profit 🤤🤑. \n\nThis is calculated by Crypto Loss/Gain Calculator.";
  }
  await Share.share(shareText);
}

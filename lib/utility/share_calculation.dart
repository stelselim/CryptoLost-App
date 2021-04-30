import 'package:cryptolostapp/application/models/calculations.dart';
import 'package:cryptolostapp/utility/analytics/google_anayltics_functions.dart';
import 'package:share/share.dart';

Future<void> shareCalculation(Calculation calculation) async {
  final profit = calculation.profit.toStringAsFixed(2);

  final percentage = calculation.percentage.toStringAsFixed(2);
  final coin = calculation.coinModel;
  var shareText = "";
  if (calculation.isLoss) {
    shareText =
        "You loss %$percentage by ${coin.name}. The profit is $profit 🙁😞. \n\nThis is calculated by Crypto Loss/Gain Calculator. \nhttps://apps.apple.com/us/app/crypto-loss-gain-calculator/id1563553737 ";
  } else {
    shareText =
        "You gained %$percentage by ${coin.name}. The profit is $profit 🤤🤑. \n\nThis is calculated by Crypto Loss/Gain Calculator. \nhttps://apps.apple.com/us/app/crypto-loss-gain-calculator/id1563553737";
  }
  await shareCalculationEvent();
  await Share.share(shareText);
}

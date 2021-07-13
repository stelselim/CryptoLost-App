import 'package:fluttertoast/fluttertoast.dart';

double amountTextToDouble(String amountText) {
  try {
    if (amountText.contains(',')) {
      return double.parse(amountText.replaceAll(',', "."));
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Invalid Amount");
  }
  return double.parse(amountText);
}

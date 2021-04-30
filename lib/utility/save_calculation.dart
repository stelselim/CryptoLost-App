import 'dart:convert';
import 'package:cryptolostapp/application/models/calculations.dart';
import 'package:cryptolostapp/application/models/coin.dart';
import 'package:shared_preferences/shared_preferences.dart';

const calculationKey = "CALCULATIONS";

Future<List<Calculation>> getCalculations() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // await prefs.clear();
  var local = prefs.getString(calculationKey);
  if (local == null) return [];
  List<dynamic> tempList = jsonDecode(local);

// Update Old Calculations
  updateCalculationsFromOld(prefs, tempList);

  final calculations = List.generate(
    tempList.length,
    (index) {
      return Calculation.fromJson(tempList.elementAt(index));
    },
  );
  return calculations;
}

Future<void> saveNewCalculation(Calculation calculationValue) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var calculations = await getCalculations();
  calculations.add(calculationValue);
  await prefs.setString(calculationKey, jsonEncode(calculations));
}

Future<void> deleteCalculation(int index) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var calculations = await getCalculations();
  calculations.removeAt(index);
  await prefs.setString(calculationKey, jsonEncode(calculations));
}

Future<void> clearCalculations() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(calculationKey);
}

Future<List<Calculation>> updateCalculationsFromOld(
    SharedPreferences prefs, List<dynamic> list) async {
  List<Calculation> calculationList = [];
  for (String e in list) {
    Map<String, dynamic> x = jsonDecode(e);

    if (x.containsKey("dateTime")) {
      var local = Calculation(
        profit: x["profit"],
        coinModel: CoinModel.fromMap(x['coinModel']),
        currentDateTime: DateTime.now(),
        isLoss: x["isLoss"],
        percentage: x["percentage"],
        oldDateTime: DateTime.fromMillisecondsSinceEpoch(x["dateTime"]),
      );
      calculationList.add(local);
    } else {
      var local = Calculation.fromMap(x);
      calculationList.add(local);
    }
  }

  await prefs.setString(calculationKey, jsonEncode(calculationList));
  return calculationList;
}

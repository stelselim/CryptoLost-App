import "dart:convert";
import "package:cryptolostapp/application/models/calculations.dart";
import "package:cryptolostapp/application/models/coin.dart";
import "package:shared_preferences/shared_preferences.dart";

const calculationKey = "CALCULATIONS";

Future<List<Calculation>> getCalculations() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final local = prefs.getString(calculationKey);
  if (local == null) return [];
  final List<dynamic> tempList = jsonDecode(local) as List<dynamic>;

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
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final calculations = await getCalculations();
  calculations.add(calculationValue);
  await prefs.setString(calculationKey, jsonEncode(calculations));
}

Future<void> deleteCalculation(int index) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final calculations = await getCalculations();
  calculations.removeAt(index);
  await prefs.setString(calculationKey, jsonEncode(calculations));
}

Future<void> clearCalculations() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(calculationKey);
}

Future<List<Calculation>> updateCalculationsFromOld(
    SharedPreferences prefs, List<dynamic> list) async {
  final List<Calculation> calculationList = [];
  for (final String e in list) {
    final Map<String, dynamic> x = jsonDecode(e) as Map<String, dynamic>;

    if (x.containsKey("dateTime")) {
      final local = Calculation(
        profit: x["profit"],
        coinModel: CoinModel.fromMap(x["coinModel"]),
        currentDateTime: DateTime.now(),
        isLoss: x["isLoss"],
        percentage: x["percentage"],
        oldDateTime: DateTime.fromMillisecondsSinceEpoch(x["dateTime"]),
      );
      calculationList.add(local);
    } else {
      final local = Calculation.fromMap(x);
      calculationList.add(local);
    }
  }

  await prefs.setString(calculationKey, jsonEncode(calculationList));
  return calculationList;
}

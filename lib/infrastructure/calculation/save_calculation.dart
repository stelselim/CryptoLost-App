import "dart:convert";
import 'package:cryptolostapp/application/models/portfolio_calculations.dart';
import "package:cryptolostapp/application/models/coin.dart";
import "package:shared_preferences/shared_preferences.dart";

const calculationKey = "CALCULATIONS";

Future<List<PorfolioCalculation>> getPortfolioCalculations() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final local = prefs.getString(calculationKey);
  if (local == null) return [];
  final List<dynamic> tempList = jsonDecode(local) as List<dynamic>;

  // Update Old Calculations
  // For the old version of the App.
  updateCalculationsFromOld(prefs, tempList);

  final calculations = List.generate(
    tempList.length,
    (index) {
      return PorfolioCalculation.fromJson(tempList.elementAt(index));
    },
  );
  return calculations;
}

Future<void> saveNewPortfolioCalculations(
    PorfolioCalculation calculationValue) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final calculations = await getPortfolioCalculations();
  calculations.add(calculationValue);
  await prefs.setString(calculationKey, jsonEncode(calculations));
}

Future<void> deletePortfolioCalculations(int index) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final calculations = await getPortfolioCalculations();
  calculations.removeAt(index);
  await prefs.setString(calculationKey, jsonEncode(calculations));
}

Future<void> clearPortfolioCalculations() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(calculationKey);
}

Future<List<PorfolioCalculation>> updateCalculationsFromOld(
    SharedPreferences prefs, List<dynamic> list) async {
  final List<PorfolioCalculation> calculationList = [];
  for (final String e in list) {
    final Map<String, dynamic> x = jsonDecode(e) as Map<String, dynamic>;

    if (x.containsKey("dateTime")) {
      final local = PorfolioCalculation(
        profit: x["profit"],
        coinModel: CoinModel.fromMap(x["coinModel"]),
        currentDateTime: DateTime.now(),
        isLoss: x["isLoss"],
        percentage: x["percentage"],
        oldDateTime: DateTime.fromMillisecondsSinceEpoch(x["dateTime"]),
      );
      calculationList.add(local);
    } else {
      final local = PorfolioCalculation.fromMap(x);
      calculationList.add(local);
    }
  }

  await prefs.setString(calculationKey, jsonEncode(calculationList));
  return calculationList;
}

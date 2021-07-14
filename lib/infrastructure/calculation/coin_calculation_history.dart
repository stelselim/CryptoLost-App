import 'dart:convert';
import 'package:cryptolostapp/application/models/history_calculations.dart';
import 'package:cryptolostapp/domains/calculation_history_domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

const calculationHistorySharedPreferencesKey = "CALCULATION_HISTORY";

class CoinCalculationHistoryRepository extends CalculationHistoryDomain {
  @override
  Future<List<HistoryCalculation>> getCalculationHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final history = prefs.getString(calculationHistorySharedPreferencesKey);
    if (history == null) {
      return [];
    } else {
      final List<dynamic> list = jsonDecode(history) as List<dynamic>;
      return List.generate(
        list.length,
        (index) {
          return HistoryCalculation.fromJson(list.elementAt(index));
        },
      );
    }
  }

  @override
  Future<void> addACalculationToHistory(HistoryCalculation calculation) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final history = await getCalculationHistory();
    history.add(calculation);
    await prefs.setString(
        calculationHistorySharedPreferencesKey, jsonEncode(history));
  }

  @override
  Future<void> deleteACalculation(HistoryCalculation calculation) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final history = await getCalculationHistory();
    history.remove(calculation);
    await prefs.setString(
        calculationHistorySharedPreferencesKey, jsonEncode(history));
  }

  @override
  Future<void> deleteAllCalculationHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(calculationHistorySharedPreferencesKey);
  }
}

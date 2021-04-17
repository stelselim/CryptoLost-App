import 'dart:convert';

import 'package:cryptolostapp/application/models/calculations.dart';
import 'package:shared_preferences/shared_preferences.dart';

const calculationKey = "CALCULATIONS";

Future<List<Calculation>> getCalculations() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // await prefs.clear();
  var local = prefs.getString(calculationKey);
  if (local == null) return [];
  List<dynamic> tempList = jsonDecode(local);
  final calculations = List.generate(
    tempList.length,
    (index) => Calculation.fromJson(tempList.elementAt(index)),
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

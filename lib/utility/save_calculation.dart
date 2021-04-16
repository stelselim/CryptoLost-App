import 'dart:convert';

import 'package:cryptolostapp/application/models/calculations.dart';
import 'package:shared_preferences/shared_preferences.dart';

const calculationKey = "CALCULATIONS";

Future<List<Calculation>> getCalculations() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var local = prefs.getString(calculationKey);
  if (local == null) return [];
  List<Map<String, dynamic>> tempList = jsonDecode(local);
  final calculations = List.generate(
    tempList.length,
    (index) => Calculation.fromMap(tempList.elementAt(index)),
  );
  return calculations;
}

Future saveNewCalculation(Calculation calculationValue) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var calculations = await getCalculations();
  calculations.add(calculationValue);
  await prefs.setString(calculationKey, jsonEncode(calculations));
}

Future clearCalculations() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(calculationKey);
}

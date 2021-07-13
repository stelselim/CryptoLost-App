import 'package:cryptolostapp/application/models/history_calculations.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class CalculationHistoryDomain {
  Future<List<HistoryCalculation>> getCalculationHistory();

  Future<void> deleteAllCalculationHistory();

  Future<void> addACalculationToHistory(HistoryCalculation calculation);

  Future<void> deleteACalculation(HistoryCalculation calculation);
}

import 'dart:math';

import 'package:cryptolostapp/application/models/progress_model.dart';

List<num> calculateMoneySteps(
  num initialMoney,
  int percentage,
  int numberOfWeeks,
) {
  final List<num> moneySteps = [];
  final int days = numberOfWeeks * 7;
  num currentStepMoney = initialMoney;
  moneySteps.add(currentStepMoney);

  for (int i = 0; i < days; i++) {
    currentStepMoney = currentStepMoney + (currentStepMoney * percentage / 100);
    currentStepMoney =
        (currentStepMoney * 100).round() / 100; // 2 number after ,
    moneySteps.add(currentStepMoney);
  }
  return moneySteps;
}

ProgressModel createProgressModelFromUserInput(
  String currency,
  num initialMoney,
  int percentage,
  int numberOfWeeks,
) {
  final steps = calculateMoneySteps(
    initialMoney,
    percentage,
    numberOfWeeks,
  );
  return ProgressModel(
    id: Random().nextInt(100000000).toString(),
    name: "Money Ladder",
    initialMoney: initialMoney,
    currency: currency,
    percentage: percentage,
    durationInWeeks: numberOfWeeks,
    steps: steps,
    goalMoney: steps.last,
    currentStepIndex: 0,
    journeyDates: const [],
    lastUpdated: DateTime.now(),
    createdDate: DateTime.now(),
  );
}

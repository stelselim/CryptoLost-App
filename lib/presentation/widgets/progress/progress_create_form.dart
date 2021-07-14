import 'dart:math';

import 'package:cryptolostapp/application/models/progress_model.dart';
import 'package:flutter/material.dart';

final dummyProgressData = ProgressModel(
  id: Random().nextInt(100000000).toString(),
  name: "Progress Name",
  initialMoney: 1001,
  currency: "USD",
  percentage: 1,
  goalMoney: 10000,
  durationInWeeks: 10,
  steps: const [1001, 1002.1, 1003.3],
  currentStepIndex: 0,
  journeyDates: const [],
  lastUpdated: DateTime.now(),
  createdDate: DateTime.now(),
);

class ProgressCreateForm extends StatelessWidget {
  final void Function(ProgressModel model) onCreate;

  const ProgressCreateForm({
    Key? key,
    required this.onCreate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () => onCreate(dummyProgressData),
          child: const Text("Create A  New"),
        ),
      ],
    );
  }
}

import 'package:cryptolostapp/application/models/progress_model.dart';
import 'package:cryptolostapp/utility/date_formatter.dart';
import 'package:flutter/material.dart';

class ProgressListTile extends StatelessWidget {
  final ProgressModel progressModel;
  const ProgressListTile({
    Key? key,
    required this.progressModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(progressModel.name),
          Text("Daily Percentage: %${progressModel.percentage.toString()}"),
          Text("Created At ${formatDate(progressModel.createdDate)}"),
          Text("Updated At ${formatDate(progressModel.lastUpdated)}"),
          Text("${progressModel.durationInWeeks} Weeks"),
          Text("Goal: ${progressModel.goalMoney.toString()}"),
          Text(progressModel.steps[progressModel.currentStepIndex]
              .toStringAsFixed(2)),
          Text("Budget: ${progressModel.initialMoney.toStringAsFixed(2)}"),
        ],
      ),
    );
  }
}

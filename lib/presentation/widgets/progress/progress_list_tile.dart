import 'package:cryptolostapp/application/models/progress_model.dart';
import 'package:cryptolostapp/utility/currency_formatter.dart';
import 'package:cryptolostapp/utility/date_formatter.dart';
import 'package:cryptolostapp/utility/routes/routes.dart';
import 'package:flutter/material.dart';

class ProgressListTile extends StatelessWidget {
  final ProgressModel progressModel;
  const ProgressListTile({
    Key? key,
    required this.progressModel,
  }) : super(key: key);

  static const double smallIconSize = 16;

  static final smallTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    color: Colors.blueGrey.shade600,
    fontSize: 14,
  );

  static final currentMoneyTextStyle = TextStyle(
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w600,
    color: Colors.blueGrey.shade600,
    fontSize: 36,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 15,
      ),
      child: Card(
        child: TextButton(
          onPressed: () => Navigator.pushNamed(context, progressDetailsRoute),
          child: Container(
            height: 250,
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              size: smallIconSize,
                              color: Colors.purple,
                            ),
                            Text(
                              " Updated: ${formatDate(progressModel.lastUpdated)}",
                              style: smallTextStyle,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              size: smallIconSize,
                              color: Colors.deepOrange,
                            ),
                            Text(
                              " Created: ${formatDate(progressModel.createdDate)}",
                              style: smallTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.flag_rounded,
                              size: smallIconSize,
                              color: Colors.blue,
                            ),
                            Text(
                              " Percentage: %${progressModel.percentage.toString()}",
                              style: smallTextStyle,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.timelapse,
                              size: smallIconSize,
                              color: Colors.indigo,
                            ),
                            Text(
                              " ${progressModel.durationInWeeks} Weeks",
                              style: smallTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                // Current Balance Header
                Text(
                  "Current Balance",
                  textScaleFactor: 1.12,
                  style: smallTextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // Balance
                Text(
                  "${formatMoney(progressModel.steps[progressModel.currentStepIndex])} ${progressModel.currency} ",
                  textAlign: TextAlign.center,
                  style: currentMoneyTextStyle,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "STAIR ${progressModel.currentStepIndex + 1}",
                  textScaleFactor: 1.12,
                  style: smallTextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Divider(
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.title_sharp,
                              size: smallIconSize + 3,
                              color: Colors.green.shade500,
                            ),
                            Text(
                              progressModel.name,
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.15,
                              style: smallTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.assignment,
                              size: smallIconSize,
                              color: Colors.red.shade500,
                            ),
                            Text(
                              " Goal: ${progressModel.goalMoney.toString()}",
                              style: smallTextStyle,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.account_balance_sharp,
                              size: smallIconSize,
                              color: Colors.green.shade500,
                            ),
                            Text(
                              " Budget: ${progressModel.initialMoney.toStringAsFixed(2)}",
                              style: smallTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

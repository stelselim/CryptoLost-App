import 'dart:math';
import 'package:cryptolostapp/application/models/progress_model.dart';
import 'package:cryptolostapp/infrastructure/progress/progress_utils.dart';
import 'package:cryptolostapp/presentation/widgets/general/bordered_text_field.dart';
import 'package:cryptolostapp/utility/analytics/google_anayltics_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProgressCreateForm extends StatelessWidget {
  final void Function(ProgressModel model) onCreate;

  const ProgressCreateForm({
    Key? key,
    required this.onCreate,
  }) : super(key: key);

  static String currency = "USD";
  static int percentageValue = 2;
  static int durationInWeeks = 6;
  static final moneyController = TextEditingController();

  void createButtonFunction(
    String currency,
    num? initialMoney,
    int percentage,
    int numberOfWeeks,
  ) {
    if (initialMoney == null) {
      Fluttertoast.showToast(msg: "Enter Initial Money Amount!");
      return;
    }

    final ProgressModel model = createProgressModelFromUserInput(
      currency,
      initialMoney,
      percentage,
      numberOfWeeks,
    );
    onCreate(model);
    createProgressEvent();
  }

  static const SizedBox spaceBox = SizedBox(
    height: 15,
  );

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => Container(
        width: 250,
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Currency
              Container(
                decoration: BoxDecoration(
                    color: Colors.white30,
                    border: Border.all(
                      width: 0.8,
                      color: Colors.black87,
                    ),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('USD'),
                      onTap: () => setState(() => currency = "USD"),
                      leading: Radio<String>(
                        value: "USD",
                        groupValue: currency,
                        onChanged: (String? value) =>
                            setState(() => currency = value!),
                      ),
                    ),
                    ListTile(
                      title: const Text('EURO'),
                      onTap: () => setState(() => currency = "EURO"),
                      leading: Radio<String>(
                          value: "EURO",
                          groupValue: currency,
                          onChanged: (String? value) {
                            setState(() => currency = value!);
                            print(value);
                          }),
                    ),
                  ],
                ),
              ),
              spaceBox,

              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white30,
                    border: Border.all(
                      width: 0.8,
                      color: Colors.black87,
                    ),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    // Percentage
                    Column(
                      children: [
                        Slider(
                          value: percentageValue.toDouble(),
                          max: 10,
                          min: 1,
                          label: "Percentage $percentageValue",
                          onChanged: (val) => setState(
                            () => percentageValue = val.toInt(),
                          ),
                        ),
                        Text(
                          "Daily Percentage: % $percentageValue",
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // Duration
                    Column(
                      children: [
                        Slider(
                          value: durationInWeeks.toDouble(),
                          max: 14,
                          min: 2,
                          label: "Duration $durationInWeeks",
                          onChanged: (val) => setState(
                            () => durationInWeeks = val.toInt(),
                          ),
                        ),
                        Text(
                          "Duration in Weeks: $durationInWeeks",
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              spaceBox,
              // Money
              BorderedTextField(
                controller: moneyController,
                label: "Initial Money",
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp("[0-9.,]"),
                  ),
                ],
                // inputBorder: InputBorder.none,
                textInputType: TextInputType.number,
              ),
              spaceBox,
              TextButton(
                onPressed: () => createButtonFunction(
                  currency,
                  num.tryParse(moneyController.text),
                  percentageValue,
                  durationInWeeks,
                ),
                child: const Text(
                  "Create",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                  textScaleFactor: 1.25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

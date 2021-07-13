import 'package:cryptolostapp/application/models/calculations.dart';
import 'package:cryptolostapp/presentation/widgets/saved_calculations_widget.dart';
import 'package:cryptolostapp/presentation/widgets/total_calculations_widget.dart';
import 'package:cryptolostapp/utility/save_calculation.dart';
import 'package:flutter/material.dart';

class SavedCalculationsScreen extends StatelessWidget {
  const SavedCalculationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setStateFromBuilder) =>
          FutureBuilder<List<Calculation>>(
              future: getCalculations(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: Text("There is No Saved Data"));
                }

                if (snapshot.hasError) {
                  return const Center(child: Text("An Error Occured"));
                }

                if (snapshot.data!.isEmpty) {
                  return const Center(child: Text("There is No Saved Data"));
                }

                return Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.blueGrey,
                              child: TotalCalculations(
                                calculations: snapshot.data,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 18.0),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final AlertDialog alert = AlertDialog(
                                      title:
                                          const Text("Delete All Calculations"),
                                      content: const Text(
                                          "Calculations can not recovered."),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("No"),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            try {
                                              await clearCalculations();
                                              Navigator.pop(context);
                                              setStateFromBuilder(() {});
                                            } catch (e) {
                                              print(e);
                                            }
                                          },
                                          child: const Text("Yes"),
                                        ),
                                      ],
                                    );
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return alert;
                                      },
                                    );
                                  },
                                  child: const Text("Delete All"),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return SavedCalculationWidget(
                                  context: context,
                                  index: index,
                                  setState: setStateFromBuilder,
                                  localcalculation:
                                      snapshot.data!.elementAt(index),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
    );
  }
}

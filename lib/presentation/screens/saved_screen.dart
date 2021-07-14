import 'package:cryptolostapp/application/models/portfolio_calculations.dart';
import 'package:cryptolostapp/presentation/widgets/saved_calculations_widget.dart';
import 'package:cryptolostapp/presentation/widgets/total_calculations_widget.dart';
import 'package:cryptolostapp/infrastructure/calculation/save_calculation.dart';
import 'package:flutter/material.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setStateFromBuilder) =>
          FutureBuilder<List<PorfolioCalculation>>(
        future: getPortfolioCalculations(),
        builder: (context, snapshot) {
          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("There is No Saved Data"),
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setStateFromBuilder(() {});
                    },
                    child: const Text("Refresh"),
                  ),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(child: Text("An Error Occured")),
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setStateFromBuilder(() {});
                    },
                    child: const Text("Refresh"),
                  ),
                ],
              ),
            );
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
                child: RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(const Duration(milliseconds: 200));
                    setStateFromBuilder(() {});
                  },
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
                                  title: const Text("Delete All Calculations"),
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
                                          await clearPortfolioCalculations();
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
                              localcalculation: snapshot.data!.elementAt(index),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

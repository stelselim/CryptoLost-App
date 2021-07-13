import 'package:cryptolostapp/application/models/history_calculations.dart';
import 'package:cryptolostapp/infrastructure/calculation/coin_calculation_history.dart';
import 'package:cryptolostapp/presentation/widgets/history/history_coin_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CalculationHistoryScreen extends StatelessWidget {
  const CalculationHistoryScreen({Key? key}) : super(key: key);
  static CoinCalculationHistoryRepository coinCalculationHistoryRepository =
      CoinCalculationHistoryRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculation History"),
      ),
      body: StatefulBuilder(
        builder: (context, setStateFromBuilder) =>
            FutureBuilder<List<HistoryCalculation>>(
          future: coinCalculationHistoryRepository.getCalculationHistory(),
          builder: (context, snapshot) {
            if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const Center(child: Text("There is no history."));
            }

            if (snapshot.hasError) {
              return const Center(child: Text("An Error Occured"));
            }

            return RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(milliseconds: 200));
                setStateFromBuilder(() {});
              },
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            final AlertDialog alert = AlertDialog(
                              title: const Text("Delete All Calculations"),
                              content:
                                  const Text("Calculations can not recovered."),
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
                                      await coinCalculationHistoryRepository
                                          .deleteAllCalculationHistory();
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
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final element = snapshot.data!.elementAt(index);

                        return HistoryCoinWidget(
                          historyCalculation: element,
                          deleteHistoryCalculation: () async {
                            try {
                              await CoinCalculationHistoryRepository()
                                  .deleteACalculation(element);
                              Navigator.pop(context);
                              Fluttertoast.showToast(
                                  msg: "Calculation Deleted");
                              setStateFromBuilder(() {});
                            } catch (e) {
                              print(e);
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:cryptolostapp/application/models/coin.dart';
import 'package:cryptolostapp/infrastructure/coins.dart';
import 'package:cryptolostapp/presentation/widgets/coin_comparison.dart';
import 'package:cryptolostapp/presentation/widgets/coins_dropdown_item.dart';

import 'package:cryptolostapp/utility/screensizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CoinModel? selectedCoin; // Selected Value for Dropdown
  DateTime? selectedDate; // Selected Date

  CoinModel? historyOfCoin; // Resulted Value
  CoinModel? currentResultCoin; // Resulted Value
  DateTime? historyOfDate; // Resulted Date
  num? resultCoinAmount; // Result Amount

  List<CoinModel>? values;
  final amountTextController = TextEditingController();
  final FocusNode amountNode = FocusNode();

  final CoinDataRepository coinDataRepository = CoinDataRepository();

  Future getData() async {
    var res = await coinDataRepository.getCoins();
    setState(() {
      values = res;
    });
  }

  Future<DateTime?> pickDate() async {
    final res = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(Duration(days: 1)),
      firstDate: DateTime(2015),
      lastDate: DateTime.now().subtract(Duration(days: 1)),
    );
    return res;
  }

  @override
  void dispose() {
    amountTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        amountNode.unfocus();
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            // INPUT
            if (values == null)
              CircularProgressIndicator()
            else
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    vertical: getSize(context).height * 0.025,
                    horizontal: getSize(context).width * 0.21,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey, width: 1.5),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: getSize(context).height * 0.025,
                    horizontal: getSize(context).width * 0.06,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Dropdown
                      Expanded(
                        flex: 2,
                        child: DropdownButton<CoinModel>(
                          hint: Text("Select"),
                          underline: Container(),
                          onChanged: (val) {
                            try {
                              setState(() {
                                selectedCoin = val;
                              });
                            } catch (e) {
                              print(e);
                            }
                          },
                          value: selectedCoin,
                          items: coinsDropDown(values),
                        ),
                      ),
                      // TextField
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: amountTextController,
                          focusNode: amountNode,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          maxLines: 1,
                          onEditingComplete: () {
                            amountNode.unfocus();
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r"[0-9.]")),
                          ],
                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            hintText: "Amount",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            // Date Select
            Expanded(
              flex: 1,
              child: selectedDate != null
                  ? ListTile(
                      leading: IconButton(
                        icon: Icon(
                          Icons.edit,
                          size: 35,
                        ),
                        onPressed: () async {
                          try {
                            selectedDate = await pickDate();
                            setState(() {});
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          size: 35,
                        ),
                        onPressed: () {
                          setState(() {
                            selectedDate = null;
                          });
                        },
                      ),
                      title: Text(
                        DateFormat('MM-dd-yyyy').format(selectedDate!),
                        textScaleFactor: 1.25,
                        style: TextStyle(
                          color: Colors.blueGrey.shade600,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : CupertinoButton(
                      child: Text("Select Date"),
                      onPressed: () async {
                        try {
                          selectedDate = await pickDate();

                          setState(() {});
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
            ),
            SizedBox(
              height: 10,
            ),
            // Calculate Button
            Expanded(
              flex: 1,
              child: Container(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Calculate",
                      textScaleFactor: 1.25,
                    ),
                  ),
                  onPressed: () async {
                    amountNode.unfocus();

                    if (amountTextController.text == "") {
                      Fluttertoast.showToast(msg: "Please enter amount");
                    }

                    if (selectedCoin == null) {
                      Fluttertoast.showToast(msg: "Select a coin");
                    }
                    if (selectedDate == null) {
                      Fluttertoast.showToast(msg: "Select a date");
                    }

                    if (selectedCoin != null &&
                        selectedDate != null &&
                        amountTextController.text != "") {
                      try {
                        var coinResultLocal =
                            await coinDataRepository.getCoinsSpesificDate(
                          selectedCoin!.id!,
                          selectedDate!,
                        );
                        setState(() {
                          currentResultCoin = selectedCoin!.copyWith();
                          historyOfCoin = coinResultLocal!.copyWith();
                          historyOfDate = selectedDate;
                          resultCoinAmount =
                              num.parse(amountTextController.text);
                        });
                      } catch (e) {
                        print(e);
                        Fluttertoast.showToast(msg: "Error Occured");
                      }
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Divider(),
            ),

            Expanded(
              flex: 8,
              child: Container(
                child: (currentResultCoin != null &&
                        historyOfCoin != null &&
                        historyOfDate != null)
                    ? CoinComparisonList(
                        historyDate: historyOfDate,
                        coinAmount: resultCoinAmount,
                        currentCoin: currentResultCoin,
                        historyOfCoin: historyOfCoin,
                      )
                    : Container(
                        child: Text("Calculate a loss :)"),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

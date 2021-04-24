import 'package:cryptolostapp/application/models/coin.dart';
import 'package:cryptolostapp/application/provider/appstate.dart';
import 'package:cryptolostapp/infrastructure/coins.dart';
import 'package:cryptolostapp/presentation/widgets/coin_comparison.dart';
import 'package:cryptolostapp/presentation/widgets/coins_dropdown_item.dart';
import 'package:cryptolostapp/utility/admob/admob_interstitial.dart';
import 'package:cryptolostapp/utility/analytics/google_anayltics_functions.dart';
import 'package:cryptolostapp/utility/date_picker.dart';

import 'package:cryptolostapp/utility/screensizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CoinModel? selectedCoin; // Selected Value for Dropdown
  DateTime? selectedDate; // Selected Date for Calculation
  final amountTextController =
      TextEditingController(); // Amount TextField Controller
  final FocusNode amountNode = FocusNode(); // Amount Keyboard Node

  CoinModel? historyOfCoin; // Resulted Value
  CoinModel? currentResultCoin; // Resulted Value
  DateTime? historyOfDate; // Resulted Date
  num? resultCoinAmount; // Result Amount

  final CoinDataRepository coinDataRepository =
      CoinDataRepository(); // Coins Data Repository

  Future getData(BuildContext context) async {
    if (Provider.of<AppState>(context, listen: false).coins == null) {
      var res = await coinDataRepository.getCoins();
      Provider.of<AppState>(context, listen: false).setCoins(res);
    }
  }

  @override
  void dispose() {
    amountTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final headertextStyle = TextStyle(
      color: Colors.blueGrey.shade700,
      fontWeight: FontWeight.w600,
      fontSize: 17,
      height: 1.35,
    );
    return Consumer<AppState>(
      builder: (context, appstate, _) => GestureDetector(
        onTap: () {
          amountNode.unfocus();
        },
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              // Text
              Padding(
                padding: const EdgeInsets.only(top: 23.0, left: 18),
                child: Wrap(
                  children: [
                    Text(
                      "Enter your cripto from PAST, and compare CURRENT value!",
                      style: headertextStyle,
                    ),
                  ],
                ),
              ),
              // INPUT Loading
              if (appstate.coins == null)
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: CircularProgressIndicator(),
                )
              // COINS Loaded
              else
                Expanded(
                  flex: 3,
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
                      vertical: getSize(context).height * 0.014,
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
                            items: coinsDropDown(appstate.coins),
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
                flex: 2,
                child: selectedDate != null
                    ? ListTile(
                        leading: IconButton(
                          icon: Icon(
                            Icons.edit,
                            size: 35,
                          ),
                          onPressed: () async {
                            try {
                              selectedDate = await pickDate(context);
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
                        title: TextButton(
                          onPressed: () async {
                            try {
                              selectedDate = await pickDate(context);
                              setState(() {});
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Text(
                            DateFormat('MM-dd-yyyy').format(selectedDate!),
                            textScaleFactor: 1.25,
                            style: TextStyle(
                              color: Colors.blueGrey.shade600,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : CupertinoButton(
                        child: Text("Select Date"),
                        onPressed: () async {
                          try {
                            selectedDate = await pickDate(context);

                            setState(() {});
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
              ),
              // Space
              SizedBox(
                height: 10,
              ),
              // Calculate Button
              Expanded(
                flex: 2,
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
                      await calculateEvent();

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
                          Fluttertoast.showToast(msg: "Calculated!");
                          setState(() {
                            currentResultCoin = selectedCoin!.copyWith();
                            historyOfCoin = coinResultLocal!.copyWith();
                            historyOfDate = selectedDate;
                            resultCoinAmount =
                                num.parse(amountTextController.text);
                          });
                          await showIntertitial();
                        } catch (e) {
                          print(e);
                          Fluttertoast.showToast(msg: "Error Occured");
                        }
                      }
                    },
                  ),
                ),
              ),

              // Divider
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Divider(),
              ),

              // Coin Comparison
              Expanded(
                flex: 10,
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
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
                                padding: EdgeInsets.all(35),
                                child: Text(
                                  "Calculate a LOSS :)",
                                  style: headertextStyle,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

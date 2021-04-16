import 'package:cryptolostapp/application/models/coin.dart';
import 'package:cryptolostapp/infrastructure/coins.dart';
import 'package:cryptolostapp/presentation/widgets/coins_dropdown_item.dart';

import 'package:cryptolostapp/utility/screensizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CoinModel? selectedCoin; // Selected Value
  DateTime? selectedDate; // Selected Date

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Coin Loss & Gain Calculator"),
      ),
      body: GestureDetector(
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
                child: CupertinoButton(
                  child: Text("Select Date"),
                  onPressed: () async {
                    selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2015),
                      lastDate: DateTime.now(),
                    );
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
                      if (selectedCoin != null &&
                          selectedDate != null &&
                          amountTextController.text != "") {
                        try {
                          var r = await coinDataRepository.getCoinsSpesificDate(
                            selectedCoin!.id!,
                            selectedDate!,
                          );
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                    // color: Colors.red,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cryptolostapp/application/classes/coinComparisonClass.dart';
import 'package:cryptolostapp/application/models/coin.dart';
import 'package:cryptolostapp/application/provider/appstate.dart';
import 'package:cryptolostapp/infrastructure/coins.dart';
import 'package:cryptolostapp/presentation/styles/textStyles.dart';
import 'package:cryptolostapp/presentation/widgets/coin_comparison.dart';
import 'package:cryptolostapp/presentation/widgets/coins_dropdown_item.dart';
import 'package:cryptolostapp/utility/admob/admob_config.dart';
import 'package:cryptolostapp/utility/admob/admob_interstitial.dart';
import 'package:cryptolostapp/utility/amountTextToDouble.dart';
import 'package:cryptolostapp/utility/analytics/google_anayltics_functions.dart';
import 'package:cryptolostapp/utility/date_picker.dart';

import 'package:cryptolostapp/utility/screensizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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

  CoinComparisonClass?
      coinComparisonClass; // Contains All States for Calculation

  InterstitialAd? interstitialAd; // Interstial Ad
  bool showAd = false; // check to show ad

// Show ad with setState
  void showAdFunction() {
    setState(() {
      showAd = true;
    });
  }

// Hide ad with setState
  void hideAdFunction() {
    setState(() {
      showAd = false;
    });
  }

  // Get Coins Data
  Future<void> getData(BuildContext context) async {
    if (Provider.of<AppState>(context, listen: false).coins == null) {
      final CoinDataRepository coinDataRepository =
          CoinDataRepository(); // Coins Data Repository
      var res = await coinDataRepository.getCoins();
      Provider.of<AppState>(context, listen: false).setCoins(res);
    }
  }

  // Calculate Gain Loss
  Future<void> calculateButtonPressed() async {
    amountNode.unfocus();

    if (amountTextController.text == "") {
      Fluttertoast.showToast(msg: "Please enter amount");
      return;
    }

    if (selectedCoin == null) {
      Fluttertoast.showToast(msg: "Select a coin");
      return;
    }
    if (selectedDate == null) {
      Fluttertoast.showToast(msg: "Select a date");
      return;
    }

    if (selectedCoin != null &&
        selectedDate != null &&
        amountTextController.text != "") {
      // Count An Event
      await calculateEvent();
      try {
        final CoinDataRepository coinDataRepository =
            CoinDataRepository(); // Coins Data Repository

        var coinResultLocal = await coinDataRepository.getCoinsSpesificDate(
          selectedCoin!.id!,
          selectedDate!,
        );
        Fluttertoast.showToast(msg: "Calculated!");
        setState(
          () {
            coinComparisonClass = CoinComparisonClass(
              currentResultCoin: selectedCoin!.copyWith(),
              historyOfCoin: coinResultLocal!.copyWith(),
              historyOfDate: selectedDate!,
              resultCoinAmount: amountTextToDouble(amountTextController.text),
            );
          },
        );
        if (interstitialAd != null) {
          await loadInterstitial(interstitialAd!);
        }
      } catch (e) {
        print(e);
        Fluttertoast.showToast(msg: "Error Occured");
      }
    }
  }

  void checkAd() {
    // If true show intersitial ad
    if (showAd && interstitialAd != null) {
      interstitialAd!.show();
    }
  }

  @override
  void initState() {
    super.initState();

    // Get Coins Data
    getData(context);
    // Initialize IntersitialAd
    interstitialAd = InterstitialAd(
      adUnitId: interstitialAdUnitId,
      listener: AdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) {
          showAdFunction();
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) => print('Ad opened.'),
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {
          ad.dispose();
          hideAdFunction();
        },
        // Called when an ad is in the process of leaving the application.
        onApplicationExit: (Ad ad) => print('Left application.'),
      ),
      request: AdRequest(),
    );
  }

  @override
  void dispose() {
    amountTextController.dispose();
    interstitialAd!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // show the ad if conditions true
    checkAd();

    return Consumer<AppState>(
      builder: (context, appstate, _) => GestureDetector(
        onTap: () => amountNode.unfocus(), // Unfocus Keyboard
        child: Container(
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
                      horizontal: getSize(context).width * 0.15,
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
                          flex: 3,
                          child: DropdownButton<CoinModel>(
                            hint: Text("Select"),
                            underline: Container(),
                            onChanged: (val) => setState(() {
                              selectedCoin = val;
                            }),
                            value: selectedCoin,
                            items: coinsDropDown(appstate.coins),
                          ),
                        ),
                        // TextField
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: amountTextController,
                            focusNode: amountNode,
                            keyboardType: TextInputType.text,
                            maxLines: 1,
                            onEditingComplete: () => amountNode.unfocus(),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"[0-9.,]")),
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
                    onPressed: calculateButtonPressed,
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
                        padding: EdgeInsets.only(bottom: 25),
                        child: coinComparisonClass != null
                            ? CoinComparisonList(
                                coinComparison: coinComparisonClass!,
                              )
                            : Container(
                                padding: EdgeInsets.all(35),
                                child: Text(
                                  "Calculate a LOSS or GAIN :)",
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

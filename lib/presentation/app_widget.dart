import 'dart:io';

import 'package:cryptolostapp/application/provider/appstate.dart';
import 'package:cryptolostapp/presentation/screens/coins_screen.dart';
import 'package:cryptolostapp/presentation/screens/home_screen.dart';
import 'package:cryptolostapp/presentation/screens/portfolio_screen.dart';

import 'package:cryptolostapp/utility/analytics/google_anayltics_functions.dart';
import 'package:cryptolostapp/utility/routes/routes.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  static PreferredSizeWidget appBarWidget(BuildContext context) {
    const title = Text("Loss & Gain Calculator");

    final drawerButton = IconButton(
      onPressed: () {
        print("Hey");
      },
      icon: const Icon(Icons.menu),
    );
    final historyButton = IconButton(
      onPressed: () =>
          Navigator.pushNamed(context, coinCalculationHistoryRoute),
      icon: const Icon(
        Icons.history,
      ),
    );

    if (Platform.isAndroid) {
      return AppBar(
        title: title,
        centerTitle: true,
        leading: drawerButton,
        actions: [
          historyButton,
        ],
      );
    } else {
      return CupertinoNavigationBar(
        middle: title,
        leading: drawerButton,
        trailing: Wrap(
          children: [
            historyButton,
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appstate, _) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBarWidget(context),
        body: IndexedStack(
          index: appstate.index,
          children: const [
            HomeScreen(),
            CoinsScreen(),
            PortfolioScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: appstate.index,
          onTap: (val) {
            if (val == 0) {
              homeScreenEvent();
            } else if (val == 1) {
              coinsScreenEvent();
            } else if (val == 2) {
              savedScreenEvent();
            }
            Provider.of<AppState>(context, listen: false).updateIndex(val);
          },
          items: const [
            BottomNavigationBarItem(
              label: "Calculator",
              icon: Icon(Icons.calculate),
            ),
            BottomNavigationBarItem(
              label: "Coins",
              icon: Icon(Icons.list_alt),
            ),
            BottomNavigationBarItem(
              label: "Portfolio",
              icon: Icon(Icons.bar_chart),
            ),
          ],
        ),
      ),
    );
  }
}

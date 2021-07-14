import 'dart:io';

import 'package:cryptolostapp/application/provider/appstate.dart';
import 'package:cryptolostapp/presentation/screens/coins_screen.dart';
import 'package:cryptolostapp/presentation/screens/home_screen.dart';
import 'package:cryptolostapp/presentation/screens/progress_screen.dart';
import 'package:cryptolostapp/presentation/screens/saved_screen.dart';

import 'package:cryptolostapp/utility/analytics/google_anayltics_functions.dart';
import 'package:cryptolostapp/utility/routes/routes.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  static PreferredSizeWidget appBarWidget(BuildContext context, int index) {
    String title = "";

    switch (index) {
      case 0:
        title = "Loss & Gain Calculator";
        break;
      case 1:
        title = "Coins";
        break;
      case 2:
        title = "Money Ladder"; // Progress Screen Special Name
        break;
      case 3:
        title = "Saved Calculations";
        break;
      default:
        title = "Loss & Gain Calculator";
        break;
    }

    final drawerButton = IconButton(
      onPressed: () {
        Fluttertoast.showToast(
          msg: "New Features Coming Soon!",
          gravity: ToastGravity.CENTER,
        );
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
        title: Text(title),
        centerTitle: true,
        leading: drawerButton,
        actions: [
          historyButton,
        ],
      );
    } else {
      return CupertinoNavigationBar(
        middle: Text(title),
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
        appBar: appBarWidget(context, appstate.index),
        body: IndexedStack(
          index: appstate.index,
          children: const [
            HomeScreen(),
            CoinsScreen(),
            ProgressScreen(),
            SavedScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black45,
          showUnselectedLabels: true,
          currentIndex: appstate.index,
          onTap: (val) {
            if (val == 0) {
              homeScreenEvent();
            } else if (val == 1) {
              coinsScreenEvent();
            } else if (val == 2) {
              progressScreenEvent();
            } else if (val == 3) {
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
              label: "Money Ladder",
              icon: Icon(Icons.auto_graph_sharp),
            ),
            BottomNavigationBarItem(
              label: "Saved",
              icon: Icon(Icons.bar_chart),
            ),
          ],
        ),
      ),
    );
  }
}

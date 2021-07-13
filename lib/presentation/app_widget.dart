import 'dart:io';

import 'package:cryptolostapp/application/provider/appstate.dart';
import 'package:cryptolostapp/presentation/screens/home.dart';
import 'package:cryptolostapp/presentation/screens/saved_calculations.dart';
import 'package:cryptolostapp/presentation/screens/selected_date_screen.dart';
import 'package:cryptolostapp/utility/analytics/google_anayltics_functions.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  static PreferredSizeWidget appBarWidget() {
    if (Platform.isAndroid) {
      return AppBar(
        title: const Text("Coin Loss & Gain Calculator"),
      );
    } else {
      return const CupertinoNavigationBar(
        middle: Text("Coin Loss & Gain Calculator"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appstate, _) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBarWidget(),
        body: IndexedStack(
          index: appstate.index,
          children: const [
            HomeScreen(),
            SelectedDateCoinScreen(),
            SavedCalculationsScreen(),
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
              label: "Gain / Loss",
              icon: Icon(Icons.format_indent_decrease),
            ),
            BottomNavigationBarItem(
              label: "Coins",
              icon: Icon(Icons.list_alt),
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

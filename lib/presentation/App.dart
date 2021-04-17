import 'dart:io';

import 'package:cryptolostapp/application/provider/appstate.dart';
import 'package:cryptolostapp/presentation/screens/home.dart';
import 'package:cryptolostapp/presentation/screens/saved_calculations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  static PreferredSizeWidget appBarWidget() {
    if (Platform.isAndroid) {
      return AppBar(
        title: Text("Coin Loss & Gain Calculator"),
      );
    } else {
      return CupertinoNavigationBar(
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
          children: [
            HomeScreen(),
            SavedCalculationsScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: appstate.index,
          onTap: (val) {
            Provider.of<AppState>(context, listen: false).updateIndex(val);
          },
          items: [
            BottomNavigationBarItem(
              label: "Gain / Loss",
              icon: Icon(Icons.format_indent_decrease),
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

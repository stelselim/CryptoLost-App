import 'dart:io';

import 'package:cryptolostapp/application/provider/appstate.dart';
import 'package:cryptolostapp/presentation/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  static Widget homeBody(BuildContext context) {
    int index = Provider.of<AppState>(context).index;
    if (index == 0) {
      return HomeScreen();
    }
    if (index == 1) {
      return Container(
        color: Colors.red,
      );
    }
    return Container(
      color: Colors.blue,
    );
  }

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
    var currentIndex = Provider.of<AppState>(context, listen: false).index;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBarWidget(),
      body: homeBody(context),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
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
    );
  }
}

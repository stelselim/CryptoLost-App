import 'package:cryptolostapp/presentation/screens/home.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  int currentIndex = 0;

  Widget homeBody(int index) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Coin Loss & Gain Calculator"),
      ),
      body: homeBody(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (val) {
          setState(() {
            currentIndex = val;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: "Loss",
            icon: Icon(Icons.format_indent_decrease),
          ),
          BottomNavigationBarItem(
            label: "Save",
            icon: Icon(Icons.bar_chart),
          ),
        ],
      ),
    );
  }
}

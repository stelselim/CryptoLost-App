import 'package:cryptolostapp/infrastructure/coins.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text("Here"),
      ),
      body: Center(
        child: TextButton(
          child: Text("Press"),
          onPressed: () async {
            try {
              await getCurrentCoinExchanges();
            } catch (e) {
              print(e);
            }
          },
        ),
      ),
    );
  }
}

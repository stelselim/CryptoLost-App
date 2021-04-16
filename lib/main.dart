import 'package:cryptolostapp/application/provider/appstate.dart';
import 'package:cryptolostapp/presentation/App.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppState(),
        )
      ],
      child: MaterialApp(
        title: 'Crypto Loss Calculator',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AppWidget(),
      ),
    );
  }
}

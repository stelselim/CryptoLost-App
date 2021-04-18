import 'package:cryptolostapp/application/provider/appstate.dart';
import 'package:cryptolostapp/presentation/App.dart';
import 'package:cryptolostapp/utility/analytics/google_anayltics_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(App());
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            appNotOpenedEvent();
            return Text("An Error Occured");
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            appOpensEvent();
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

          return Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          );
        });
  }
}

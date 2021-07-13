import 'package:cryptolostapp/application/provider/appstate.dart';
import 'package:cryptolostapp/presentation/app_widget.dart';
import 'package:cryptolostapp/presentation/screens/history_screen.dart';
import 'package:cryptolostapp/utility/admob/admob_initialize.dart';
import 'package:cryptolostapp/utility/analytics/google_anayltics_functions.dart';
import 'package:cryptolostapp/utility/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Initiliaze Admob
  initializeAdmob();
  dotenv.load(); // Loads .env
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
            return const Text("An Error Occured");
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
                title: 'Crypto Gain Loss',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                initialRoute: "/",
                routes: {
                  homeRoute: (context) => const AppWidget(),
                  coinCalculationHistoryRoute: (context) =>
                      const CalculationHistoryScreen(),
                },
              ),
            );
          }

          return Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          );
        });
  }
}

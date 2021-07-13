import 'package:cryptolostapp/main.dart';
import 'package:cryptolostapp/utility/admob/admob_initialize.dart';
import 'package:cryptolostapp/utility/keys/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Initiliaze Admob
  initializeAdmob();
  dotenv.load(); // Loads .env

  testWidgets("Test Case 1", (WidgetTester tester) async {
    await tester.pumpWidget(App());
    await tester.pumpAndSettle();
    final coinDropdown = find.byKey(coinDropDownKey);
    expect(coinDropdown, findsOneWidget);

    await tester.tap(find.byKey(coinDropDownKey));
    await tester.pumpAndSettle();

    final dropdownButton = find.byKey(const Key("bitcoin"));
    await tester.tap(dropdownButton.first, warnIfMissed: false);

    await tester.enterText(find.byKey(textFieldKey), "12.2");

    await tester.tap(find.byKey(dateSelectButtonKey));
    await tester.pumpAndSettle();

    await tester.tap(find.text("OK")); // Select Today Date
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(calculateButtonKey),
        warnIfMissed: false); // Select Today Date
    await tester.pumpAndSettle();

    expect(find.byKey(coinComparisonBottomKey), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
  });

  testWidgets("Test Case 2 & Ad Test", (WidgetTester tester) async {
    await tester.pumpWidget(App());
    await tester.pumpAndSettle();
    final coinDropdown = find.byKey(coinDropDownKey);
    expect(coinDropdown, findsOneWidget);

    await tester.tap(find.byKey(coinDropDownKey));
    await tester.pumpAndSettle();

    final dropdownButton = find.byKey(const Key("bitcoin"));
    await tester.tap(dropdownButton.first, warnIfMissed: false);

    await tester.enterText(find.byKey(textFieldKey), "12,2");

    await tester.tap(find.byKey(dateSelectButtonKey));
    await tester.pumpAndSettle();

    await tester.tap(find.text("OK")); // Select Today Date
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(calculateButtonKey),
        warnIfMissed: false); // Select Today Date
    await tester.pumpAndSettle();

    expect(find.byKey(coinComparisonBottomKey), findsOneWidget);

    await tester.pump(const Duration(seconds: 10)); // Check Ad show up.
  });
}

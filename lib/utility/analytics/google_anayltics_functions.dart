import 'package:cryptolostapp/utility/analytics/analytics_events.dart'
    as events;
import 'package:firebase_analytics/firebase_analytics.dart';

Future appOpensEvent() async {
  try {
    final FirebaseAnalytics analytics = FirebaseAnalytics();
    await analytics.logAppOpen();
  } catch (e) {
    print(e);
  }
}

Future homeScreenEvent() async {
  try {
    final FirebaseAnalytics analytics = FirebaseAnalytics();
    await analytics.logEvent(
      name: events.HOMESCREEN_OPENED_EVENT,
    );
  } catch (e) {
    print(e);
  }
}

Future historyScreenEvent() async {
  try {
    final FirebaseAnalytics analytics = FirebaseAnalytics();
    await analytics.logEvent(
      name: events.HISTORYSCREEN_OPENED_EVENT,
    );
  } catch (e) {
    print(e);
  }
}

Future progressScreenEvent() async {
  try {
    final FirebaseAnalytics analytics = FirebaseAnalytics();
    await analytics.logEvent(
      name: events.PROGRESSSCREEN_OPENED_EVENT,
    );
  } catch (e) {
    print(e);
  }
}

Future progressDetailedPScreenEvent() async {
  try {
    final FirebaseAnalytics analytics = FirebaseAnalytics();
    await analytics.logEvent(
      name: events.PROGRESS_DETAILED_SCREEN_OPENED_EVENT,
    );
  } catch (e) {
    print(e);
  }
}

Future coinsScreenEvent() async {
  try {
    final FirebaseAnalytics analytics = FirebaseAnalytics();
    await analytics.logEvent(
      name: events.COINSSCREEN_OPENED_EVENT,
    );
  } catch (e) {
    print(e);
  }
}

Future savedScreenEvent() async {
  try {
    final FirebaseAnalytics analytics = FirebaseAnalytics();
    await analytics.logEvent(
      name: events.SAVEDSCREEN_OPENED_EVENT,
    );
  } catch (e) {
    print(e);
  }
}

Future appNotOpenedEvent() async {
  try {
    final FirebaseAnalytics analytics = FirebaseAnalytics();
    await analytics.logEvent(
      name: events.APP_NOT_OPENED_EVENT,
    );
  } catch (e) {
    print(e);
  }
}

Future calculateEvent() async {
  try {
    final FirebaseAnalytics analytics = FirebaseAnalytics();
    await analytics.logEvent(
      name: events.CRYPTO_CALCULATION_EVENT,
    );
  } catch (e) {
    print(e);
  }
}

Future createProgressEvent() async {
  try {
    final FirebaseAnalytics analytics = FirebaseAnalytics();
    await analytics.logEvent(
      name: events.PROGRESS_CREATED_EVENT,
    );
  } catch (e) {
    print(e);
  }
}

Future updateProgressEvent() async {
  try {
    final FirebaseAnalytics analytics = FirebaseAnalytics();
    await analytics.logEvent(
      name: events.PROGRESS_UPDATED_EVENT,
    );
  } catch (e) {
    print(e);
  }
}

Future interstitialAdOpenedEvent() async {
  try {
    final FirebaseAnalytics analytics = FirebaseAnalytics();
    await analytics.logEvent(
      name: events.INTERSTITIAL_ADS_OPENED_EVENT,
    );
  } catch (e) {
    print(e);
  }
}

Future interstitialAdFailedEvent() async {
  try {
    final FirebaseAnalytics analytics = FirebaseAnalytics();
    await analytics.logEvent(
      name: events.INTERSTITIAL_ADS_FAILED_EVENT,
    );
  } catch (e) {
    print(e);
  }
}

Future coinsDetailOpenedEvent() async {
  try {
    final FirebaseAnalytics analytics = FirebaseAnalytics();
    await analytics.logEvent(
      name: events.COIN_DETAILS_TAPPED_EVENT,
    );
  } catch (e) {
    print(e);
  }
}

Future savedCalculationEvent() async {
  try {
    final FirebaseAnalytics analytics = FirebaseAnalytics();
    await analytics.logEvent(
      name: events.SAVED_CALCULATION_EVENT,
    );
  } catch (e) {
    print(e);
  }
}

Future shareCalculationEvent() async {
  try {
    final FirebaseAnalytics analytics = FirebaseAnalytics();
    await analytics.logEvent(
      name: events.SHARE_CALCULATION_EVENT,
    );
  } catch (e) {
    print(e);
  }
}

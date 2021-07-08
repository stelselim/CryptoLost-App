import 'package:cryptolostapp/utility/admob/admob_config.dart';
import 'package:cryptolostapp/utility/admob/admob_count.dart';
import 'package:cryptolostapp/utility/analytics/google_anayltics_functions.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future loadInterstitial(InterstitialAd interstitialAd) async {
  int count = await admobCount();

  // Show Ad, after 2 operations
  if (count == 1) {
    await interstitialAd.load();

    if (await interstitialAd.isLoaded()) {
      print("Ads Success");
      await interstitialAdOpenedEvent();
    } else {
      print("Ads failed");
      await interstitialAdFailedEvent();
    }

    await admobCountClear();
  }
  // Increase count
  else {
    await admobCountAdd();
  }
}

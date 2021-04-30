import 'package:cryptolostapp/utility/admob/admob_config.dart';
import 'package:cryptolostapp/utility/admob/admob_count.dart';
import 'package:cryptolostapp/utility/analytics/google_anayltics_functions.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future showIntertitial() async {
  String unitId = interstitialAdUnitId;

  final AdListener listener = AdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      ad.dispose();
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => ad.dispose(),
    // Called when an ad is in the process of leaving the application.
    onApplicationExit: (Ad ad) => print('Left application.'),
  );
  final adRequest = AdRequest();

  InterstitialAd interstitialAd = InterstitialAd(
    adUnitId: unitId,
    listener: listener,
    request: adRequest,
  );

  int count = await admobCount();

  // Show Ad, after 2 operations
  if (count == 1) {
    await interstitialAd.load();
    await Future.delayed(Duration(milliseconds: 1500));

    if (await interstitialAd.isLoaded()) {
      print("Ads Success");
      await interstitialAdOpenedEvent();
      await interstitialAd.show();
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

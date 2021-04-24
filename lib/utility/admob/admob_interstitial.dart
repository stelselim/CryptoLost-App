import 'package:cryptolostapp/utility/admob/admob_config.dart';
import 'package:cryptolostapp/utility/admob/admob_count.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';

Future showIntertitial() async {
  String unitId = interstitialAdUnitId;

  InterstitialAd interstitialAd = InterstitialAd(
    unitId: unitId,
  );

  int count = await admobCount();

  // Show Ad, after 2 operations
  if (count == 2) {
    if (!interstitialAd.isAvailable) {
      await interstitialAd.load();
    }
    if (interstitialAd.isAvailable) {
      interstitialAd.show();
    }
    await admobCountClear();
  }
  // Increase count
  else {
    await admobCountAdd();
  }
}

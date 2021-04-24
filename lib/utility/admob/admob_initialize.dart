import 'dart:io';
import 'package:cryptolostapp/utility/admob/admob_config.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';

Future initializeAdmob() async {
  try {
    await MobileAds.initialize(
      interstitialAdUnitId: interstitialAdUnitId,
    );
    // await MobileAds.setTestDeviceIds(["82b36ef993798d6011be39e5526979a1"]);
  } catch (e) {
    Fluttertoast.showToast(msg: e.toString());
    print(e);
  }
}

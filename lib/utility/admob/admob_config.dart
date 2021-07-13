import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String get interstitialAdUnitId {
  /// Always test with test ads
  ///
  final iosUnitId = dotenv.env['iOSInterstitialUnitId'] ?? '';
  final androidUnitId = dotenv.env['AndroidInterstitialUnitId'] ?? '';

  if (kDebugMode) {
    if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/5135589807";
    } else {
      return "ca-app-pub-3940256099942544/8691691433";
    }
  } else {
    if (Platform.isIOS) {
      return iosUnitId;
    } else {
      return androidUnitId;
    }
  }
}

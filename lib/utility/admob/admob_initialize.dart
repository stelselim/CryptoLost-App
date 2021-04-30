import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future initializeAdmob() async {
  try {
    await MobileAds.instance.initialize();
  } catch (e) {
    Fluttertoast.showToast(msg: e.toString());
    print(e);
  }
}

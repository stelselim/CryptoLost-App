import 'package:shared_preferences/shared_preferences.dart';

const intersititialAdCount = "IntersititialAdCount";

Future<int> admobCount() async {
  final instance = await SharedPreferences.getInstance();
  final count = instance.getInt(intersititialAdCount);

  if (count == null) {
    await instance.setInt(intersititialAdCount, 0);
    return 0;
  } else {
    return count;
  }
}

Future<void> admobCountAdd() async {
  final instance = await SharedPreferences.getInstance();
  var count = instance.getInt(intersititialAdCount);
  if (count != null) {
    count += 1;
    await instance.setInt(intersititialAdCount, count);
  } else {
    await instance.setInt(intersititialAdCount, 0);
  }
}

Future<void> admobCountClear() async {
  final instance = await SharedPreferences.getInstance();
  await instance.setInt(intersititialAdCount, 0);
}

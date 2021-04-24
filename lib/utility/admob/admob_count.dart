import 'package:shared_preferences/shared_preferences.dart';

const IntersititialAdCount = "IntersititialAdCount";

Future<int> admobCount() async {
  final instance = await SharedPreferences.getInstance();
  var count = instance.getInt(IntersititialAdCount);

  if (count == null) {
    await instance.setInt(IntersititialAdCount, 0);
    return 0;
  } else {
    return count;
  }
}

Future<void> admobCountAdd() async {
  final instance = await SharedPreferences.getInstance();
  var count = instance.getInt(IntersititialAdCount);
  if (count != null) {
    count += 1;
    await instance.setInt(IntersititialAdCount, count);
  } else {
    await instance.setInt(IntersititialAdCount, 0);
  }
}

Future<void> admobCountClear() async {
  final instance = await SharedPreferences.getInstance();
  await instance.setInt(IntersititialAdCount, 0);
}

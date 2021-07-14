import 'dart:convert';

import 'package:cryptolostapp/application/models/progress_model.dart';
import 'package:cryptolostapp/domains/progress_domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

const progressSharedPreferencesKey = "PROGRESS";

class ProgressRepository extends ProgressDomain {
  @override
  Future<void> createProgress(ProgressModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final progresses = await getProgressList();
    progresses.add(model);
    await prefs.setString(progressSharedPreferencesKey, jsonEncode(progresses));
  }

  @override
  Future<void> deleteAllProgress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(progressSharedPreferencesKey);
  }

  @override
  Future<void> deleteProgress(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final progresses = await getProgressList();
    progresses.removeWhere((element) => element.id == id);
    await prefs.setString(progressSharedPreferencesKey, jsonEncode(progresses));
  }

  @override
  Future<ProgressModel> getProgress(String id) async {
    final progresses = await getProgressList();
    return progresses.firstWhere((element) => element.id == id);
  }

  @override
  Future<List<ProgressModel>> getProgressList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final local = prefs.getString(progressSharedPreferencesKey);
    if (local == null) return [];
    final List<dynamic> tempList = jsonDecode(local) as List<dynamic>;

    final progesses = List.generate(
      tempList.length,
      (index) {
        return ProgressModel.fromJson(tempList.elementAt(index));
      },
    );
    return progesses;
  }

  @override
  Future<void> updateProgress(ProgressModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final progresses = await getProgressList();
    final element = progresses.firstWhere((element) => element.id == model.id);
    progresses.indexOf(element);
    progresses[progresses.indexOf(element)] = model;

    await prefs.setString(progressSharedPreferencesKey, jsonEncode(progresses));
  }
}

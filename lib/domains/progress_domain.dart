import 'package:cryptolostapp/application/models/progress_model.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class ProgressDomain {
  Future<List<ProgressModel>> getProgressList();

  Future<void> createProgress(ProgressModel model);

  Future<ProgressModel> getProgress(String id);

  Future<void> updateProgress(ProgressModel model);

  Future<void> deleteProgress(String id);

  Future<void> deleteAllProgress();
}

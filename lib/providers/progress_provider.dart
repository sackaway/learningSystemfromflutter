import 'package:flutter/material.dart';

class ProgressProvider with ChangeNotifier {
  Map<String, Set<String>> _completedSections = {};

  double getProgress(String courseId, int totalSections) {
    if (!_completedSections.containsKey(courseId)) return 0;
    return (_completedSections[courseId]!.length / totalSections);
  }

  void completeSection(String courseId, String sectionTitle) {
    if (!_completedSections.containsKey(courseId)) {
      _completedSections[courseId] = {};
    }
    _completedSections[courseId]!.add(sectionTitle);
    notifyListeners();
  }

  bool isSectionCompleted(String courseId, String sectionTitle) {
    return _completedSections.containsKey(courseId) &&
        _completedSections[courseId]!.contains(sectionTitle);
  }
}

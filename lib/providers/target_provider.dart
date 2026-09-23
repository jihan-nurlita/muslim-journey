import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/target/data/target_data.dart';

class TargetProvider extends ChangeNotifier {
  int streak = 0;

  double get progress {
    final done = targetList.where((e) => e.isDone).length;

    return done / targetList.length;
  }

  int get completedCount {
    return targetList.where((e) => e.isDone).length;
  }

  Future<void> loadTargets() async {
    final prefs = await SharedPreferences.getInstance();

    for (int i = 0; i < targetList.length; i++) {
      targetList[i].isDone = prefs.getBool('target_$i') ?? false;
    }

    streak = prefs.getInt('streak') ?? 0;

    notifyListeners();
  }

  Future<void> saveTargets() async {
    final prefs = await SharedPreferences.getInstance();

    for (int i = 0; i < targetList.length; i++) {
      prefs.setBool(
        'target_$i',
        targetList[i].isDone,
      );
    }

    prefs.setString(
      'last_date',
      DateTime.now().toIso8601String(),
    );
  }

  Future<void> toggleTarget(int index) async {
    targetList[index].isDone = !targetList[index].isDone;

    await saveTargets();

    checkStreak();

    notifyListeners();
  }

  Future<void> checkStreak() async {
    final prefs = await SharedPreferences.getInstance();

    final allDone = targetList.every((e) => e.isDone);

    if (allDone) {
      streak++;

      prefs.setInt('streak', streak);
    }
  }
}

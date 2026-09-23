import 'package:shared_preferences/shared_preferences.dart';

class TargetStorageService {
  static const String targetKey = 'ibadah_targets';

  static Future<void> saveTargets(
    List<bool> targetStates,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final converted = targetStates.map((e) => e.toString()).toList();

    await prefs.setStringList(
      targetKey,
      converted,
    );
  }

  static Future<List<bool>> loadTargets() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getStringList(targetKey);

    if (data == null) return [];

    return data.map((e) => e == 'true').toList();
  }
}

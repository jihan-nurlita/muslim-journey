import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/target/models/target_model.dart';

class TargetProvider extends ChangeNotifier {
  List<TargetModel> _targetList = [];
  Map<String, int> dailyProgress = {}; // Format key: "YYYY-MM-DD_JudulHabit"
  int streak = 0;

  TargetProvider() {
    loadTargets();
  }

  List<TargetModel> get targets => _targetList;

  // Format tanggal YYYY-MM-DD
  String dateKey(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  /// 1. MUAT DATA DARI DISK
  Future<void> loadTargets() async {
    final prefs = await SharedPreferences.getInstance();

    // Load daftar habit
    final String? savedListString = prefs.getString('custom_target_list');
    if (savedListString != null && savedListString.isNotEmpty) {
      final List<dynamic> decodedList = jsonDecode(savedListString);
      _targetList =
          decodedList.map((item) => TargetModel.fromJson(item)).toList();
    } else {
      _targetList = [];
    }

    // Load progress harian
    final String? savedProgress = prefs.getString('daily_habit_progress');
    if (savedProgress != null && savedProgress.isNotEmpty) {
      final Map<String, dynamic> decodedProgress = jsonDecode(savedProgress);
      dailyProgress =
          decodedProgress.map((key, value) => MapEntry(key, value as int));
    }

    streak = prefs.getInt('streak') ?? 0;

    // Hitung ulang streak saat data dimuat agar selalu akurat
    _calculateStreak();
    notifyListeners();
  }

  /// 2. SIMPAN DAFTAR HABIT
  Future<void> saveCustomTargets() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedList =
        jsonEncode(_targetList.map((e) => e.toJson()).toList());
    await prefs.setString('custom_target_list', encodedList);
  }

  /// 3. SIMPAN PROGRESS HARIAN & HITUNG STREAK
  Future<void> saveDailyProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('daily_habit_progress', jsonEncode(dailyProgress));

    // Hitung dan simpan streak setiap kali progress disimpan
    _calculateStreak();
    await prefs.setInt('streak', streak);
  }

  /// FUNGSI PRIVATE: Menghitung hari berturut-turut (Streak) secara akurat
  void _calculateStreak() {
    if (_targetList.isEmpty) {
      streak = 0;
      return;
    }

    int currentStreak = 0;
    DateTime checkDate = DateTime.now();

    // Cek mundur ke hari-hari sebelumnya
    for (int i = 0; i < 365; i++) {
      final dateStr = dateKey(checkDate);
      bool isAllCompletedOnDate = true;

      for (var target in _targetList) {
        final key = "${dateStr}_${target.title}";
        final count = dailyProgress[key] ?? 0;
        if (count < target.targetCount) {
          isAllCompletedOnDate = false;
          break;
        }
      }

      // Jika hari ini belum lengkap, cek apakah kemarin sudah lengkap (toleransi hari berjalan)
      if (!isAllCompletedOnDate && i == 0) {
        checkDate = checkDate.subtract(const Duration(days: 1));
        continue;
      }

      // Jika pada tanggal tersebut semua habit tercapai, tambah streak
      if (isAllCompletedOnDate) {
        currentStreak++;
        checkDate = checkDate.subtract(const Duration(days: 1));
      } else {
        // Terputus, hentikan perhitungan
        break;
      }
    }

    streak = currentStreak;
  }

  /// 4. TAMBAH HABIT BARU
  Future<void> addTarget(TargetModel newTarget) async {
    _targetList.add(newTarget);
    await saveCustomTargets();
    notifyListeners();
  }

  /// 5. HAPUS HABIT (Sama dengan deleteTarget)
  Future<void> removeTargetAt(int index) async {
    if (index >= 0 && index < _targetList.length) {
      _targetList.removeAt(index);
      await saveCustomTargets();
      notifyListeners();
    }
  }

  /// 6. AMBIL PROGRESS SPESIFIK BERDASARKAN TANGGAL
  int getProgressForDate(String title, DateTime date) {
    final key = "${dateKey(date)}_$title";
    return dailyProgress[key] ?? 0;
  }

  /// 7. INCREMENT ATAU TOGGLE PROGRESS (Digunakan di AllChecklistPage & HabitPage)
  Future<void> incrementProgressAt(int index, {DateTime? date}) async {
    if (index >= 0 && index < _targetList.length) {
      final target = _targetList[index];
      final targetDate = date ?? DateTime.now();
      final key = "${dateKey(targetDate)}_${target.title}";

      int current = dailyProgress[key] ?? 0;

      if (current < target.targetCount) {
        dailyProgress[key] = current + 1;
      } else {
        dailyProgress[key] = 0;
      }

      await saveDailyProgress();
      notifyListeners();
    }
  }

  /// 8. TOTAL SELESAI HARI INI (Untuk Statistik / Summary)
  int get completedCount {
    int count = 0;
    final todayStr = dateKey(DateTime.now());

    for (var target in _targetList) {
      final key = "${todayStr}_${target.title}";
      final current = dailyProgress[key] ?? 0;
      if (current >= target.targetCount) {
        count++;
      }
    }
    return count;
  }

  /// 9. PERSENTASE UNTUK GRAFIK STATISTIK (TargetPage)
  double getPercentageForDate(DateTime date) {
    final dateStr = dateKey(date);
    if (_targetList.isEmpty) return 0.0;

    int completedOnDate = 0;
    for (var target in _targetList) {
      final key = "${dateStr}_${target.title}";
      final count = dailyProgress[key] ?? 0;
      if (count >= target.targetCount) {
        completedOnDate++;
      }
    }
    return (completedOnDate / _targetList.length) * 100;
  }

  /// 10. UPDATE HABIT PROGRESS BERDASARKAN TANGGAL
  Future<void> updateHabitProgressForDate(
      String title, int targetCount, DateTime date) async {
    final key = "${dateKey(date)}_$title";
    int current = dailyProgress[key] ?? 0;

    if (current < targetCount) {
      dailyProgress[key] = current + 1;
    } else {
      dailyProgress[key] = 0;
    }

    await saveDailyProgress();
    notifyListeners();
  }

  /// 11. HAPUS TARGET HABIT
  Future<void> deleteTarget(int index) async {
    if (index >= 0 && index < _targetList.length) {
      _targetList.removeAt(index);
      await saveCustomTargets();
      notifyListeners();
    }
  }

  /// UPDATE/EDIT HABIT
  Future<void> updateTarget(int index, TargetModel updatedTarget) async {
    if (index >= 0 && index < _targetList.length) {
      _targetList[index] = updatedTarget;
      await saveCustomTargets();
      notifyListeners();
    }
  }
}

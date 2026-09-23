import 'package:flutter/material.dart';
import 'package:muslim_journey/core/constants/colors.dart';
import 'package:muslim_journey/pages/target/data/target_data.dart';
import 'package:muslim_journey/services/target_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodaySection extends StatefulWidget {
  const TodaySection({super.key});

  @override
  State<TodaySection> createState() => _TodaySectionState();
}

class _TodaySectionState extends State<TodaySection> {
  // ==========================================
  // STATE VARIABLES
  // ==========================================
  int streak = 0;

  final List<Map<String, dynamic>> habits = [
    {
      'title': 'Sholat Subuh',
      'subtitle': 'Jangan tinggalkan sholat Subuh',
      'done': true,
      'icon': Icons.wb_sunny_rounded,
    },
    {
      'title': 'Baca Quran',
      'subtitle': 'Minimal 2 halaman setiap hari',
      'done': true,
      'icon': Icons.menu_book_rounded,
    },
    {
      'title': 'Dzikir Pagi',
      'subtitle': 'Dzikir setelah Subuh',
      'done': false,
      'icon': Icons.favorite_rounded,
    },
    {
      'title': 'Sedekah',
      'subtitle': 'Berbagi kepada sesama',
      'done': false,
      'icon': Icons.volunteer_activism_rounded,
    },
    {
      'title': 'Tahajud',
      'subtitle': 'Bangun malam untuk ibadah',
      'done': true,
      'icon': Icons.nightlight_round,
    },
  ];

  // ==========================================
  // LIFECYCLE METHODS
  // ==========================================
  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await resetDailyTargets();
    await loadTargets();
    await loadSavedTargets();
    await checkStreak();
  }

  // ==========================================
  // STORAGE METHODS (SharedPreferences)
  // ==========================================
  Future<void> saveTargets() async {
    final prefs = await SharedPreferences.getInstance();

    for (int i = 0; i < targetList.length; i++) {
      prefs.setBool('target_$i', targetList[i].isDone);
    }

    prefs.setString('last_date', DateTime.now().toIso8601String());
  }

  Future<void> loadTargets() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      for (int i = 0; i < targetList.length; i++) {
        targetList[i].isDone = prefs.getBool('target_$i') ?? false;
      }
      streak = prefs.getInt('streak') ?? 0;
    });
  }

  Future<void> loadSavedTargets() async {
    final saved = await TargetStorageService.loadTargets();

    if (saved.isNotEmpty) {
      for (int i = 0; i < saved.length; i++) {
        if (i < targetList.length) {
          targetList[i].isDone = saved[i];
        }
      }
      setState(() {});
    }
  }

  Future<void> checkStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final allDone = targetList.every((e) => e.isDone);

    if (allDone) {
      streak++;
      prefs.setInt('streak', streak);
    }
  }

  Future<void> resetDailyTargets() async {
    final prefs = await SharedPreferences.getInstance();
    final lastDateString = prefs.getString('last_date');

    if (lastDateString == null) return;

    final lastDate = DateTime.parse(lastDateString);
    final now = DateTime.now();

    final isNewDay = lastDate.day != now.day ||
        lastDate.month != now.month ||
        lastDate.year != now.year;

    if (isNewDay) {
      for (var target in targetList) {
        target.isDone = false;
      }
      await saveTargets();
      setState(() {});
    }
  }

  // ==========================================
  // UI BUILD METHOD
  // ==========================================
  @override
  Widget build(BuildContext context) {
    final completed = habits.where((e) => e['done'] == true).length;
    final progress = habits.isEmpty ? 0.0 : completed / habits.length;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. PROGRESS HARI INI CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xff4A9B78), Color(0xff2E7D5A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.18),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Progress Hari Ini',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '$completed dari ${habits.length} target selesai',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 22),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 10,
                      backgroundColor: Colors.white24,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Icon(
                        Icons.local_fire_department_rounded,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$streak Hari Streak',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${(progress * 100).toInt()}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 2. PROGRESS MINGGU INI CARD
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 14,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Progress Minggu Ini',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _DayProgress(day: 'Sen', active: true),
                      _DayProgress(day: 'Sel', active: true),
                      _DayProgress(day: 'Rab', active: true, today: true),
                      _DayProgress(day: 'Kam', active: false),
                      _DayProgress(day: 'Jum', active: true),
                      _DayProgress(day: 'Sab', active: false),
                      _DayProgress(day: 'Min', active: true),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 3. TARGET KHATAM QURAN CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 14,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.auto_stories_rounded,
                          color: AppColors.primary,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Target Khatam Quran',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 6),
                            Text(
                              '18 / 30 Juz selesai',
                              style: TextStyle(
                                  color: AppColors.grey, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Text(
                          '60%',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: const LinearProgressIndicator(
                      value: 0.6,
                      minHeight: 12,
                      backgroundColor: Color(0xffE8F3EE),
                      valueColor: AlwaysStoppedAnimation(AppColors.primary),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Row(
                    children: [
                      Icon(Icons.calendar_month_rounded,
                          size: 18, color: AppColors.primary),
                      SizedBox(width: 8),
                      Text(
                        'Target selesai 12 hari lagi',
                        style: TextStyle(color: AppColors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 4. TILAWAH HARI INI CARD WITH MOTIVATION TIP
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 14,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(
                          Icons.menu_book_rounded,
                          color: AppColors.primary,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tilawah Hari Ini',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 6),
                            Text(
                              '4 dari 10 halaman selesai',
                              style: TextStyle(
                                  color: AppColors.grey, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Text(
                          '40%',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: 0.4,
                      minHeight: 10,
                      backgroundColor: Colors.grey.shade200,
                      valueColor:
                          const AlwaysStoppedAnimation(AppColors.primary),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Row(
                      children: const [
                        Icon(Icons.auto_awesome_rounded,
                            color: AppColors.primary, size: 22),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Sedikit demi sedikit, yang penting istiqomah ✨',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 5. STREAK BOTTOM CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xff4A9B78), Color(0xff2E7D5A)],
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.2),
                    blurRadius: 16,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Icon(
                      Icons.local_fire_department_rounded,
                      color: Colors.orange,
                      size: 38,
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Streak Ibadah',
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '$streak Hari Berturut-turut',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Terus pertahankan ibadahmu ✨',
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// SUB-WIDGET: DAY PROGRESS ITEM
// ==========================================
class _DayProgress extends StatelessWidget {
  final String day;
  final bool active;
  final bool today;

  const _DayProgress({
    required this.day,
    required this.active,
    this.today = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: active ? AppColors.primary : Colors.grey.shade300,
            shape: BoxShape.circle,
            border: today
                ? Border.all(
                    color: AppColors.primary,
                    width: 3,
                  )
                : null,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          day,
          style: TextStyle(
            fontSize: 12,
            color: today ? AppColors.primary : AppColors.grey,
            fontWeight: today ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

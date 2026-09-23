import 'package:flutter/material.dart';
import 'package:muslim_journey/core/constants/colors.dart';
import 'package:muslim_journey/pages/habit/habit_page.dart';
import 'package:muslim_journey/pages/home/home_page.dart';
import 'package:muslim_journey/pages/notification/notification_page.dart';
import 'package:muslim_journey/pages/profile/profile_page.dart';
import 'package:muslim_journey/pages/target/sections/monthly_section.dart';
import 'package:muslim_journey/pages/target/sections/today_section.dart';
import 'package:muslim_journey/pages/target/sections/weekly_section.dart';
import 'package:muslim_journey/services/target_storage_service.dart';

import 'data/target_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../../../providers/target_provider.dart';

class TargetPage extends StatefulWidget {
  const TargetPage({super.key});

  @override
  State<TargetPage> createState() => _TargetPageState();
}

class _TargetPageState extends State<TargetPage> {
  int streak = 0; // 🔥 STREAK

  // HITUNG PROGRESS OTOMATIS
  double get progress {
    final done = targetList.where((e) => e.isDone).length;

    return done / targetList.length;
  }

  int get doneCount {
    return targetList.where((e) => e.isDone).length;
  }

  // toggle
  final List<String> progressTabs = [
    'Hari Ini',
    'Mingguan',
    'Bulanan',
  ];

  String selectedProgress = 'Hari Ini';

  // CATEGORY LIST
  final List<String> categories = [
    'Semua',
    'Sholat',
    'Quran',
    'Dzikir',
    'Puasa',
    'Sedekah',
  ];

  String selectedCategory = 'Semua';

  // filtered list
  List get filteredTargets {
    if (selectedCategory == 'Semua') {
      return targetList;
    }

    return targetList.where((target) {
      return target.category == selectedCategory;
    }).toList();
  }

  /// shared_preferences

  // FUCTION SAVE
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

  // LOAD SAVE
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

  // FUCTION LOAD
  Future<void> loadTargets() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      for (int i = 0; i < targetList.length; i++) {
        targetList[i].isDone = prefs.getBool('target_$i') ?? false;
      }

      streak = prefs.getInt('streak') ?? 0;
    });
  }

  // SAVE STREAK
  Future<void> checkStreak() async {
    final prefs = await SharedPreferences.getInstance();

    final allDone = targetList.every((e) => e.isDone);

    if (allDone) {
      streak++;

      prefs.setInt('streak', streak);
    }
  }

  // RESET HARIAN
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

  //

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<TargetProvider>().loadTargets();
    });

    resetDailyTargets();

    saveTargets();

    loadSavedTargets();

    checkStreak();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      /// APPBAR
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Target Ibadah',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),

      bottomNavigationBar: const _BottomNavbar(
        currentIndex: 3,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TOGGLE UI PREMIUM
            SizedBox(
              height: 46,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                scrollDirection: Axis.horizontal,
                itemCount: progressTabs.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final tab = progressTabs[index];

                  final selected = selectedProgress == tab;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedProgress = tab;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: selected ? AppColors.primary : AppColors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: selected
                              ? AppColors.primary
                              : Colors.grey.shade200,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          tab,
                          style: TextStyle(
                            color: selected ? Colors.white : AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            if (selectedProgress == 'Hari Ini') ...[
              const TodaySection(),
            ],

            if (selectedProgress == 'Mingguan') ...[
              const WeeklySection(),
            ],

            if (selectedProgress == 'Bulanan') ...[
              const MonthlySection(),
            ],

            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}

class _BottomNavbar extends StatelessWidget {
  final int currentIndex;

  const _BottomNavbar({
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          /// HOME
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const HomePage(),
              ),
            );
            break;

          /// NOTIFICATION
          case 1:
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const NotificationPage()));
            break;

          /// Habit
          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const HabitPage(),
              ),
            );
            break;

          case 3:
            break;

          case 4:
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const ProfilePage()));
            break;
        }
      },
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.grey,
      selectedIconTheme: const IconThemeData(
        size: 28,
      ),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.task_alt),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.track_changes_rounded),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded),
          label: '',
        ),
      ],
    );
  }
}

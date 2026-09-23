import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:muslim_journey/core/constants/colors.dart';
import 'package:muslim_journey/pages/habit/calendar_habit_page.dart';
import 'package:muslim_journey/pages/home/home_page.dart';
import 'package:muslim_journey/pages/notification/notification_page.dart';
import 'package:muslim_journey/pages/profile/profile_page.dart';
import 'package:muslim_journey/pages/habit/add_target_page.dart';
import 'package:muslim_journey/pages/target/data/target_data.dart';
import 'package:muslim_journey/pages/target/target_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HabitPage extends StatefulWidget {
  const HabitPage({super.key});

  @override
  State<HabitPage> createState() => _HabitPageState();
}

class _HabitPageState extends State<HabitPage> {
  final ScrollController _scrollController = ScrollController();

  /// tanggal aktif
  DateTime selectedDate = DateTime.now();

  /// tanggal yang pernah dibuka
  Set<int> viewedDates = {};

  /// Menyimpan progres harian dalam memori: { "2026-09-13_NamaTarget": currentCount }
  Map<String, int> dailyProgress = {};

  final List<String> categories = [
    'Semua',
    'Sholat',
    'Quran',
    'Dzikir',
    'Puasa',
    'Sedekah',
  ];

  String selectedCategory = 'Semua';

  List get filteredTargets {
    if (selectedCategory == 'Semua') {
      return targetList;
    }

    return targetList.where((target) {
      return target.category == selectedCategory;
    }).toList();
  }

  /// Helper untuk membuat format string unik berdasarkan tanggal (YYYY-MM-DD)
  String get _dateKey {
    return "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
  }

  /// Helper untuk mendapatkan jumlah hitungan habit spesifik pada tanggal aktif
  int _getCurrentCountForTarget(String targetTitle) {
    final key = "${_dateKey}_$targetTitle";
    return dailyProgress[key] ?? 0;
  }

  @override
  void initState() {
    super.initState();
    _loadHabitData();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final today = DateTime.now().day;

      /// lebar item + margin
      const itemWidth = 77.0;

      _scrollController.animateTo(
        (today - 1) * itemWidth,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  /// Memuat data habit harian dari SharedPreferences
  Future<void> _loadHabitData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedData = prefs.getString('daily_habit_progress');

    if (savedData != null) {
      final Map<String, dynamic> decoded = jsonDecode(savedData);
      setState(() {
        dailyProgress =
            decoded.map((key, value) => MapEntry(key, value as int));
      });
    }
  }

  /// Menyimpan data habit harian ke SharedPreferences
  Future<void> _saveHabitData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('daily_habit_progress', jsonEncode(dailyProgress));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,

      bottomNavigationBar: const _BottomNavbar(currentIndex: 2),

      /// FLOATING BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddTargetPage(),
            ),
          );

          setState(() {});
        },
        child: const Icon(
          Icons.add,
          size: 32,
          color: Colors.white,
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// APPBAR
              Row(
                children: [
                  const SizedBox(width: 30),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Habit Ibadah",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CalendarHabitPage()));
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// DATE SELECTOR
              SizedBox(
                height: 85,
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: DateTime(
                    DateTime.now().year,
                    DateTime.now().month + 1,
                    0,
                  ).day,
                  itemBuilder: (context, index) {
                    final date = DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      index + 1,
                    );

                    final days = [
                      'Sen',
                      'Sel',
                      'Rab',
                      'Kam',
                      'Jum',
                      'Sab',
                      'Min',
                    ];

                    /// tanggal yang dipilih
                    final isSelected = selectedDate.day == date.day;

                    /// tanggal hari ini
                    final isToday = DateTime.now().day == date.day;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDate = date;
                        });
                      },
                      child: _buildDateItem(
                        day: days[date.weekday - 1],
                        date: date.day.toString(),
                        isSelected: isSelected,
                        isToday: isToday,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 18),

              /// CATEGORY CHIPS
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories.map((category) {
                    final isSelected = selectedCategory == category;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      child: _buildCategoryChip(
                        title: category,
                        selected: isSelected,
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 22),

              /// HABIT LIST
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 100),
                  itemCount: filteredTargets.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final target = filteredTargets[index];

                    // Hitungan spesifik untuk tanggal yang dipilih
                    final currentCount =
                        _getCurrentCountForTarget(target.title);
                    final isCompleted = currentCount >= target.targetCount;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          final key = "${_dateKey}_${target.title}";
                          if (currentCount < target.targetCount) {
                            dailyProgress[key] = currentCount + 1;
                          } else {
                            dailyProgress[key] = 0;
                          }
                        });
                        _saveHabitData();
                      },
                      child: _buildHabitTile(
                        icon: target.icon,
                        title: target.title,
                        subtitle:
                            '$currentCount/${target.targetCount} ${target.unit}',
                        schedule: '${target.frequency} • ${target.category}',
                        completed: isCompleted,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// DATE ITEM
  Widget _buildDateItem({
    required String day,
    required String date,
    required bool isSelected,
    required bool isToday,
  }) {
    return Container(
      width: 65,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primary
            : isToday
                ? AppColors.secondary
                : Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          CircleAvatar(
            radius: 18,
            backgroundColor: isSelected
                ? Colors.white24
                : isToday
                    ? Colors.white
                    : AppColors.secondary,
            child: Text(
              date,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// CATEGORY CHIP
  Widget _buildCategoryChip({
    required String title,
    bool selected = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : AppColors.secondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: selected ? Colors.white : AppColors.primary,
        ),
      ),
    );
  }

  /// HABIT TILE
  Widget _buildHabitTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required String schedule,
    required bool completed,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: completed
              ? AppColors.primary.withOpacity(0.15)
              : Colors.transparent,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          /// ICON
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              icon,
              size: 28,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(width: 16),

          /// TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  schedule,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          /// CHECK
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: completed ? AppColors.primary : Colors.transparent,
              border: Border.all(
                color: completed ? AppColors.primary : Colors.grey.shade300,
                width: 2,
              ),
            ),
            child: completed
                ? const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 18,
                  )
                : null,
          ),
        ],
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

          /// notification
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const NotificationPage(),
              ),
            );
            break;

          /// Habit
          case 2:
            break;

          /// TARGET
          case 3:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const TargetPage(),
              ),
            );
            break;

          /// PROFILE
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

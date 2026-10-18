import 'package:flutter/material.dart';
import 'package:muslim_journey/core/constants/colors.dart';
import 'package:muslim_journey/pages/habit/add_target_page.dart';
import 'package:muslim_journey/pages/habit/calendar_habit_page.dart';
import 'package:muslim_journey/pages/navigation/custom_bottom_navbar.dart';
import 'package:muslim_journey/pages/target/models/target_model.dart';
import 'package:muslim_journey/providers/target_provider.dart';
import 'package:provider/provider.dart';

class HabitPage extends StatefulWidget {
  const HabitPage({super.key});

  @override
  State<HabitPage> createState() => _HabitPageState();
}

class _HabitPageState extends State<HabitPage> {
  final ScrollController _scrollController = ScrollController();

  DateTime selectedDate = DateTime.now();

  final List<String> categories = [
    'Semua',
    'Sholat',
    'Quran',
    'Dzikir',
    'Puasa',
    'Sedekah',
  ];

  String selectedCategory = 'Semua';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final today = DateTime.now().day;
      const itemWidth = 77.0;

      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          (today - 1) * itemWidth,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final targetProvider = context.watch<TargetProvider>();
    final List<TargetModel> allTargets = targetProvider.targets;

    final List<TargetModel> filteredTargets = selectedCategory == 'Semua'
        ? allTargets
        : allTargets
            .where((target) => target.category == selectedCategory)
            .toList();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: const CustomBottomNavbar(currentIndex: 2),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddTargetPage(),
            ),
          );
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
                  Expanded(
                    child: Center(
                      child: Text(
                        "Habit Ibadah",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CalendarHabitPage(),
                        ),
                      );
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

                    final isSelected = selectedDate.day == date.day &&
                        selectedDate.month == date.month &&
                        selectedDate.year == date.year;
                    final isToday = DateTime.now().day == date.day &&
                        DateTime.now().month == date.month &&
                        DateTime.now().year == date.year;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDate = date;
                        });
                      },
                      child: _buildDateItem(
                        context: context,
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
                        context: context,
                        title: category,
                        selected: isSelected,
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 22),

              /// HABIT LIST WITH DISMISSIBLE
              Expanded(
                child: filteredTargets.isEmpty
                    ? Center(
                        child: Text(
                          'Belum ada habit. Yuk tambah!',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white54 : Colors.grey,
                          ),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.only(bottom: 100),
                        itemCount: filteredTargets.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final TargetModel target = filteredTargets[index];

                          final int currentCount =
                              targetProvider.getProgressForDate(
                            target.title,
                            selectedDate,
                          );
                          final bool isCompleted =
                              currentCount >= target.targetCount;

                          final originalIndex = allTargets.indexOf(target);

                          return Dismissible(
                            key: Key('${target.title}_$index'),
                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.startToEnd) {
                                // SWIPE KANAN: HAPUS
                                return await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: isDark
                                          ? const Color(0xff1E1E1E)
                                          : Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      title: Text(
                                        "Hapus Habit",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      content: Text(
                                        "Apakah kamu yakin ingin menghapus '${target.title}'?",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: isDark
                                              ? Colors.white70
                                              : Colors.grey,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: Text(
                                            "Batal",
                                            style: TextStyle(
                                              color: isDark
                                                  ? Colors.white54
                                                  : AppColors.grey,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                          ),
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                          child: const Text(
                                            "Hapus",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else if (direction ==
                                  DismissDirection.endToStart) {
                                // SWIPE KIRI: EDIT
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AddTargetPage(
                                      target: target,
                                      targetIndex: originalIndex,
                                    ),
                                  ),
                                );
                                return false;
                              }
                              return false;
                            },
                            onDismissed: (direction) {
                              if (direction == DismissDirection.startToEnd) {
                                targetProvider.deleteTarget(originalIndex);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '${target.title} berhasil dihapus'),
                                    backgroundColor: Colors.redAccent,
                                  ),
                                );
                              }
                            },
                            background: Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                color: Colors.red.shade400,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.delete_rounded,
                                      color: Colors.white, size: 28),
                                  SizedBox(width: 8),
                                  Text(
                                    'Hapus',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            secondaryBackground: Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade400,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Edit',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.edit_rounded,
                                      color: Colors.white, size: 28),
                                ],
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                targetProvider.updateHabitProgressForDate(
                                  target.title,
                                  target.targetCount,
                                  selectedDate,
                                );
                              },
                              child: _buildHabitTile(
                                context: context,
                                icon: target.icon,
                                title: target.title,
                                subtitle:
                                    '$currentCount/${target.targetCount} ${target.unit}',
                                schedule:
                                    '${target.frequency} ${target.category}',
                                completed: isCompleted,
                              ),
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
    required BuildContext context,
    required String day,
    required String date,
    required bool isSelected,
    required bool isToday,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color itemBgColor = isDark ? const Color(0xff1E1E1E) : Colors.white;
    if (isSelected) {
      itemBgColor = AppColors.primary;
    } else if (isToday) {
      itemBgColor = isDark ? const Color(0xff2A2A2A) : AppColors.secondary;
    }

    return Container(
      width: 65,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: itemBgColor,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isSelected
                  ? Colors.white
                  : isDark
                      ? Colors.white70
                      : AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          CircleAvatar(
            radius: 18,
            backgroundColor: isSelected
                ? Colors.white24
                : isToday
                    ? (isDark ? Colors.white24 : Colors.white)
                    : (isDark ? const Color(0xff2A2A2A) : AppColors.secondary),
            child: Text(
              date,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? Colors.white
                    : isDark
                        ? Colors.white
                        : AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// CATEGORY CHIP
  Widget _buildCategoryChip({
    required BuildContext context,
    required String title,
    bool selected = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color chipBg = isDark ? const Color(0xff1E1E1E) : AppColors.secondary;
    if (selected) {
      chipBg = AppColors.primary;
    }

    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: chipBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: selected
              ? Colors.white
              : isDark
                  ? Colors.white70
                  : AppColors.primary,
        ),
      ),
    );
  }

  /// HABIT TILE
  Widget _buildHabitTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required String schedule,
    required bool completed,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xff1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: completed
              ? AppColors.primary.withOpacity(0.15)
              : Colors.transparent,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.03),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          /// ICON DYNAMIC
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xff2A2A2A) : AppColors.secondary,
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
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 1.8),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                ),
                const SizedBox(height: 1.5),
                Text(
                  schedule,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white38 : Colors.grey,
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
                color: completed
                    ? AppColors.primary
                    : isDark
                        ? Colors.white24
                        : Colors.grey.shade300,
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

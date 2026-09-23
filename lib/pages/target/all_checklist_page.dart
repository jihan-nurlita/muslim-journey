import 'package:flutter/material.dart';
import 'package:muslim_journey/core/constants/colors.dart';
import 'package:muslim_journey/pages/target/data/target_data.dart';

class AllChecklistPage extends StatefulWidget {
  const AllChecklistPage({super.key});

  @override
  State<AllChecklistPage> createState() => _AllChecklistPageState();
}

class _AllChecklistPageState extends State<AllChecklistPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Semua Checklist',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// SEARCH
            Container(
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Cari habit...',
                  hintStyle: TextStyle(
                    color: AppColors.grey,
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: AppColors.grey,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 22),

            /// CATEGORY
            SizedBox(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final category = categories[index];

                  final isSelected = selectedCategory == category;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : AppColors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : Colors.grey.shade200,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          category,
                          style: TextStyle(
                            color: isSelected ? Colors.white : AppColors.black,
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

            /// TOTAL TEXT
            Text(
              '${filteredTargets.length} Habit Ditemukan',
              style: const TextStyle(
                color: AppColors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 18),

            /// LIST HABIT
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredTargets.length,
              separatorBuilder: (_, __) => const SizedBox(height: 18),
              itemBuilder: (context, index) {
                final target = filteredTargets[index];

                return Dismissible(
                  key: ValueKey(target.title),

                  direction: DismissDirection.endToStart,

                  onDismissed: (_) {
                    setState(() {
                      targetList.remove(target);
                    });
                  },

                  /// DELETE BG
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xffFF6B6B),
                          Color(0xffFF3B3B),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.delete_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  child: GestureDetector(
                    /// COMPLETE
                    onTap: () {
                      setState(() {
                        if (target.currentCount < target.targetCount) {
                          target.incrementProgress();
                        } else {
                          target.currentCount = 0;

                          target.isDone = false;
                        }
                      });
                    },

                    /// CARD
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.94),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: target.isCompleted
                              ? AppColors.primary.withOpacity(0.25)
                              : Colors.transparent,
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 20,
                            spreadRadius: 1,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          /// TOP
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// ICON
                              Container(
                                width: 62,
                                height: 62,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.primary.withOpacity(0.15),
                                      AppColors.primary.withOpacity(0.05),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                child: Icon(
                                  target.icon,
                                  color: AppColors.primary,
                                  size: 30,
                                ),
                              ),

                              const SizedBox(width: 16),

                              /// TEXT
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            target.title,
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                              color: target.isCompleted
                                                  ? AppColors.primary
                                                  : AppColors.black,
                                            ),
                                          ),
                                        ),
                                        if (target.isCompleted)
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.primary,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: const Text(
                                              'Selesai',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),

                                    const SizedBox(height: 6),

                                    Text(
                                      target.subtitle,
                                      style: const TextStyle(
                                        color: AppColors.grey,
                                        fontSize: 13,
                                        height: 1.5,
                                      ),
                                    ),

                                    const SizedBox(height: 14),

                                    /// TAG
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: [
                                        _miniTag(
                                          icon: Icons.category_rounded,
                                          text: target.category,
                                        ),
                                        _miniTag(
                                          icon: Icons.repeat_rounded,
                                          text: target.frequency,
                                        ),
                                        _miniTag(
                                          icon: Icons.calendar_month_rounded,
                                          text: target.activeDays.join(', '),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 22),

                          /// HEADER
                          Row(
                            children: [
                              Text(
                                '${target.currentCount}/${target.targetCount} ${target.unit}',
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '${(target.progress * 100).toInt()}%',
                                style: const TextStyle(
                                  color: AppColors.grey,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          /// PROGRESS
                          Container(
                            height: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.grey.shade200,
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: target.progress,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xff4A9B78),
                                      Color(0xff66BB8A),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),

                          /// FOOTER
                          Row(
                            children: [
                              Icon(
                                target.reminderEnabled
                                    ? Icons.notifications_active_rounded
                                    : Icons.notifications_off_rounded,
                                size: 18,
                                color: AppColors.grey,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                target.reminderEnabled
                                    ? '${target.reminderHour.toString().padLeft(2, '0')}:${target.reminderMinute.toString().padLeft(2, '0')}'
                                    : 'Reminder Off',
                                style: const TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.touch_app_rounded,
                                size: 18,
                                color: AppColors.primary.withOpacity(0.5),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Tap to progress',
                                style: TextStyle(
                                  color: AppColors.primary.withOpacity(0.7),
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

Widget _miniTag({
  required IconData icon,
  required String text,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 6,
    ),
    decoration: BoxDecoration(
      color: AppColors.background,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: AppColors.grey,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

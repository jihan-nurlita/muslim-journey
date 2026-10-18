import 'package:flutter/material.dart';
import 'package:muslim_journey/core/constants/colors.dart';
import 'package:muslim_journey/pages/target/models/target_model.dart';
import 'package:muslim_journey/providers/target_provider.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final targetProvider = context.watch<TargetProvider>();
    final List<TargetModel> allTargets = targetProvider.targets;

    final List<TargetModel> filteredTargets = selectedCategory == 'Semua'
        ? allTargets
        : allTargets.where((t) => t.category == selectedCategory).toList();

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
            Text(
              '${filteredTargets.length} Habit Ditemukan',
              style: const TextStyle(
                color: AppColors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 18),
            filteredTargets.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text(
                        'Belum ada habit.',
                        style: TextStyle(color: AppColors.grey),
                      ),
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredTargets.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 18),
                    itemBuilder: (context, index) {
                      final TargetModel target = filteredTargets[index];
                      final currentCount = targetProvider.getProgressForDate(
                          target.title, DateTime.now());
                      final isCompleted = currentCount >= target.targetCount;
                      final double progressVal = target.targetCount > 0
                          ? (currentCount / target.targetCount).clamp(0.0, 1.0)
                          : 0.0;

                      return Dismissible(
                        key: ValueKey(target.title + index.toString()),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) {
                          final originalIndex = allTargets.indexOf(target);
                          context
                              .read<TargetProvider>()
                              .removeTargetAt(originalIndex);
                        },
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 24),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(
                            Icons.delete_rounded,
                            color: Colors.white,
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            final originalIndex = allTargets.indexOf(target);
                            context
                                .read<TargetProvider>()
                                .incrementProgressAt(originalIndex);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(target.icon,
                                        color: AppColors.primary, size: 28),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        target.title,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    if (isCompleted)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: const Text(
                                          'Selesai',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  target.subtitle,
                                  style: const TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Row(
                                  children: [
                                    Text(
                                      '$currentCount/${target.targetCount} ${target.unit}',
                                      style: const TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '${(progressVal * 100).toInt()}%',
                                      style: const TextStyle(
                                        color: AppColors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
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

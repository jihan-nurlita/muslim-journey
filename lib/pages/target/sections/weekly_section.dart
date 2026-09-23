import 'package:flutter/material.dart';
import 'package:muslim_journey/core/constants/colors.dart';
import 'package:muslim_journey/pages/target/models/target_model.dart';

class WeeklySection extends StatefulWidget {
  const WeeklySection({super.key});

  @override
  State<WeeklySection> createState() => _WeeklySectionState();
}

class CategoryProgress {
  final String name;
  final double progress;
  final int done;
  final int total;

  CategoryProgress({
    required this.name,
    required this.progress,
    required this.done,
    required this.total,
  });
}

class _WeeklySectionState extends State<WeeklySection> {
  // Progress category
  List<CategoryProgress> getCategoryProgress(List<TargetModel> targetList) {
    final Map<String, List<TargetModel>> grouped = {};

    for (var t in targetList) {
      grouped.putIfAbsent(t.category, () => []);
      grouped[t.category]!.add(t);
    }

    return grouped.entries.map((e) {
      final total = e.value.length;
      final done = e.value.where((t) => t.isDone).length;

      return CategoryProgress(
        name: e.key,
        progress: total == 0 ? 0 : done / total,
        done: done,
        total: total,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            // 🔥 streak
            const SizedBox(height: 5),

            /// STREAK CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff4A9B78),
                    Color(0xff2E7D5A),
                  ],
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
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Streak Ibadah',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          '12 Hari Berturut-turut',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Terus pertahankan ibadahmu ✨',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
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
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Statistik Mingguan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _BarItem(day: 'Sen', value: 0.7),
                      _BarItem(day: 'Sel', value: 0.5),
                      _BarItem(day: 'Rab', value: 0.9),
                      _BarItem(day: 'Kam', value: 0.6),
                      _BarItem(day: 'Jum', value: 1),
                      _BarItem(day: 'Sab', value: 0.8),
                      _BarItem(day: 'Min', value: 0.4),
                    ],
                  ),
                ],
              ),
            ),

            // 📝 Ringkasan Minggu ini
            const SizedBox(height: 20),

            /// ACHIEVEMENT
            /// 3. RINGKASAN MINGGUAN CARD
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
                  const Text(
                    'Ringkasan Mingguan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _completeCard(
                          titleText: 'Total Ibadah',
                          title: '45',
                          subtitle: 'kali',
                          icon: Icons.star_rounded,
                          iconColor: const Color(0xff4A9B78),
                          bgColor: const Color(0xff4A9B78).withOpacity(0.1),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _completeCard(
                          titleText: 'Target Selesai',
                          title: '27',
                          subtitle: '/35',
                          icon: Icons.task_alt_rounded,
                          iconColor: Colors.blue,
                          bgColor: Colors.blue.withOpacity(0.1),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _completeCard(
                          titleText: 'Streak Pekan Ini',
                          title: '5',
                          subtitle: 'hari',
                          icon: Icons.local_fire_department_rounded,
                          iconColor: Colors.orange,
                          bgColor: Colors.orange.withOpacity(0.1),
                        ),
                      ),
                    ],
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

class _BarItem extends StatelessWidget {
  final String day;
  final double value;

  const _BarItem({
    required this.day,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 22,
          height: 120 * value,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          day,
          style: const TextStyle(
            color: AppColors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// Ringkasan Minggu ini
Widget _completeCard({
  required String titleText,
  required String title,
  required String subtitle,
  required IconData icon,
  required Color iconColor,
  required Color bgColor,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: Colors.grey.shade50),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.02),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment:
          CrossAxisAlignment.start, // Mengubah ke rata kiri agar lebih modern
      children: [
        // Icon Badge dengan background lingkaran tipis
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 16,
            color: iconColor,
          ),
        ),
        const SizedBox(height: 12),
        // Angka Utama
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: AppColors.black,
                height: 1,
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                subtitle,
                style: const TextStyle(
                  color: AppColors.grey,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        // Label Keterangan
        Text(
          titleText,
          style: TextStyle(
            color: AppColors.grey.withOpacity(0.8),
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

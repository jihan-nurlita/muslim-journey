// import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:muslim_journey/core/constants/colors.dart';

class MonthlySection extends StatefulWidget {
  const MonthlySection({super.key});

  @override
  State<MonthlySection> createState() => _MonthlySectionState();
}

class _MonthlySectionState extends State<MonthlySection> {
  // final PageController _pageController = PageController(initialPage: 1000);

  final DateTime baseDate = DateTime.now();

  int? selectedDay;

  int get totalItems => daysInMonth + (firstWeekday - 1); // TOTAL GRID

  // Hitung Bulan
  DateTime getMonthDate(int index) {
    return DateTime(
      baseDate.year,
      baseDate.month + (index - 1000),
      1,
    );
  }

  // LOGIC REAL CALENDAR
  DateTime now = DateTime.now();

  late int daysInMonth;
  late int firstWeekday; // posisi hari pertama (Senin/Minggu)

  // late List<DailyIbadah> data;

  late final List<DailyIbadah> data;

  @override
  void initState() {
    super.initState();

    final firstDayOfMonth = DateTime(now.year, now.month, 1);

    daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    firstWeekday = firstDayOfMonth.weekday;

    data = List.generate(
      daysInMonth,
      (index) => DailyIbadah(
        day: index + 1,
        isDone: index % 3 != 0,
        totalActivity: (index % 5) + 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // 🏆 achievement

          /// ACHIEVEMENT
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
                  'Achievement',
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
                      child: _achievementCard(
                        icon: Icons.local_fire_department_rounded,
                        title: '7 Hari',
                        subtitle: 'Streak',
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _achievementCard(
                        icon: Icons.menu_book_rounded,
                        title: '30x',
                        subtitle: 'Khatam',
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _achievementCard(
                        icon: Icons.star_rounded,
                        title: 'Level 5',
                        subtitle: 'Muslim',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // 📝 Ringkasan Minggu ini
          const SizedBox(height: 20),

          /// ACHIEVEMENT
          /// 5. RINGKASAN BULANAN CARD
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
                  'Ringkasan Bulanan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 20),

                // Baris Atas: Konsistensi Ibadah (Lebih panjang/lebar karena metrik utama)
                _monthlyCard(
                  titleText: 'Rata-rata Konsistensi',
                  title: '88%',
                  subtitle: 'Sangat Baik (Bulan ini)',
                  icon: Icons.analytics_rounded,
                  accentColor: const Color(0xff4A9B78), // Hijau khas aplikasi
                ),
                const SizedBox(height: 12),

                // Baris Bawah: Dua kolom bersebelahan
                Row(
                  children: [
                    Expanded(
                      child: _monthlyCard(
                        titleText: 'Hari Aktif',
                        title: '26',
                        subtitle: '/30 hari',
                        icon: Icons.calendar_today_rounded,
                        accentColor: Colors.purple,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _monthlyCard(
                        titleText: 'Rerata Harian',
                        title: '6.4',
                        subtitle: 'ibadah/hari',
                        icon: Icons.speed_rounded,
                        accentColor: Colors.teal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 🔥 Level
          const SizedBox(height: 24),

          /// LEVEL CARD
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Icon(
                        Icons.emoji_events_rounded,
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
                            'Level Muslim',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            'Level 5',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            '1250 / 2000 XP',
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
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: const LinearProgressIndicator(
                    value: 0.4,
                    minHeight: 10,
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

// 📅 MODEL DATA
class DailyIbadah {
  final int day;
  final bool isDone;
  final int totalActivity;

  DailyIbadah({
    required this.day,
    required this.isDone,
    required this.totalActivity,
  });
}

// Bottom Sheet DETAIL IBADAH HARIAN
class _DailyDetailSheet extends StatelessWidget {
  final DailyIbadah data;

  const _DailyDetailSheet({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Detail Ibadah Hari ke-${data.day}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green),
              const SizedBox(width: 8),
              Text(
                data.isDone ? "Target Tercapai" : "Belum Tercapai",
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.list_alt, color: Colors.orange),
              const SizedBox(width: 8),
              Text("Total Aktivitas: ${data.totalActivity}"),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// HELPER 🏆 achievement
Widget _achievementCard({
  required IconData icon,
  required String title,
  required String subtitle,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(
      vertical: 20,
      horizontal: 12,
    ),
    decoration: BoxDecoration(
      color: AppColors.background,
      borderRadius: BorderRadius.circular(24),
    ),
    child: Column(
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            color: AppColors.grey,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}

// Ringkasan Bulan ini
Widget _monthlyCard({
  required String titleText,
  required String title,
  required String subtitle,
  required IconData icon,
  required Color accentColor,
}) {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(26),
      border: Border.all(color: Colors.grey.shade100),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.02),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Row(
      children: [
        // Lingkaran Ikon berukuran medium
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: accentColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            icon,
            size: 24,
            color: accentColor,
          ),
        ),
        const SizedBox(width: 16),
        // Konten Teks
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titleText,
                style: TextStyle(
                  color: AppColors.grey.withOpacity(0.8),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      subtitle,
                      style: const TextStyle(
                        color: AppColors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildInsightCard() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xffEBF7F2), // Warna hijau mint yang sangat soft
      borderRadius: BorderRadius.circular(26),
    ),
    child: const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.lightbulb_rounded, color: Color(0xff4A9B78), size: 26),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Analisis Ibadahmu',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0xff2E7D5A)),
              ),
              SizedBox(height: 4),
              Text(
                'Grafikmu meningkat tajam di hari Jum\'at! Pekan ini sholat sunnahmu naik 15% dibanding pekan lalu. Pertahankan ritmenya, ya!',
                style: TextStyle(
                    fontSize: 13, color: Color(0xff4A9B78), height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:muslim_journey/core/constants/colors.dart';

/// Model Data untuk Puasa
class FastingInfo {
  final String title;
  final String subtitle;
  final IconData icon;
  final String arabicNiat;
  final String latinNiat;
  final String translation;

  FastingInfo({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.arabicNiat,
    required this.latinNiat,
    required this.translation,
  });
}

class PuasaPage extends StatefulWidget {
  const PuasaPage({super.key});

  @override
  State<PuasaPage> createState() => _PuasaPageState();
}

class _PuasaPageState extends State<PuasaPage> {
  late DateTime currentMonth;
  late DateTime selectedDate;

  // Menyimpan riwayat puasa yang sudah diselesaikan pengguna
  List<DateTime> completedFastingDates = [];
  static const String _storageKey = 'completed_fasting_dates';

  @override
  void initState() {
    super.initState();
    currentMonth = DateTime.now();
    selectedDate = DateTime.now();
    _loadCompletedFastingDates(); // [TAMBAHAN 1] Load data saat pertama kali dibuka
  }

  /// [TAMBAHAN 2] Fungsi membaca data dari SharedPreferences
  Future<void> _loadCompletedFastingDates() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? dateStrings = prefs.getStringList(_storageKey);

    if (dateStrings != null) {
      setState(() {
        completedFastingDates =
            dateStrings.map((str) => DateTime.parse(str)).toList();
      });
    }
  }

  /// [TAMBAHAN 3] Fungsi toggle status puasa & simpan ke SharedPreferences
  Future<void> _toggleFastingStatus(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    final normalizedDate = DateTime(date.year, date.month, date.day);

    setState(() {
      final exists = completedFastingDates.any((d) =>
          d.year == normalizedDate.year &&
          d.month == normalizedDate.month &&
          d.day == normalizedDate.day);

      if (exists) {
        completedFastingDates.removeWhere((d) =>
            d.year == normalizedDate.year &&
            d.month == normalizedDate.month &&
            d.day == normalizedDate.day);
      } else {
        completedFastingDates.add(normalizedDate);
      }
    });

    final dateStrings =
        completedFastingDates.map((d) => d.toIso8601String()).toList();
    await prefs.setStringList(_storageKey, dateStrings);
  }

  void nextMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
    });
  }

  void prevMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
    });
  }

  /// Cek apakah suatu tanggal Masehi merupakan hari puasa sunnah
  FastingInfo? getFastingInfo(DateTime date) {
    final hijri = HijriCalendar.fromDate(date);

    // 1. Puasa Senin Kamis
    if (date.weekday == DateTime.monday || date.weekday == DateTime.thursday) {
      final isMonday = date.weekday == DateTime.monday;
      return FastingInfo(
        title: isMonday ? 'Puasa Senin' : 'Puasa Kamis',
        subtitle: 'Puasa Sunnah Mingguan',
        icon: Icons.calendar_today_rounded,
        arabicNiat: isMonday
            ? 'نَوَيْتُ صَوْمَ يَوْمِ الاِثْنَيْنِ سُنَّةً لِلّٰهِ تَعَالَى'
            : 'نَوَيْتُ صَوْمَ يَوْمِ الْخَمِيسِ سُنَّةً لِلّٰهِ تَعَالَى',
        latinNiat: isMonday
            ? 'Nawaitu sauma yaumal itsnaini sunnatan lillahi ta\'ala'
            : 'Nawaitu sauma yaumal khamisi sunnatan lillahi ta\'ala',
        translation: isMonday
            ? 'Aku berniat puasa sunnah hari Senin karena Allah Ta\'ala.'
            : 'Aku berniat puasa sunnah hari Kamis karena Allah Ta\'ala.',
      );
    }

    // 2. Puasa Ayyamul Bidh (13, 14, 15 Hijriah)
    if (hijri.hDay >= 13 && hijri.hDay <= 15) {
      return FastingInfo(
        title: 'Puasa Ayyamul Bidh',
        subtitle: '${hijri.hDay} ${hijri.longMonthName}',
        icon: Icons.dark_mode_rounded,
        arabicNiat:
            'نَوَيْتُ صَوْمَ أَيَّامِ الْبِيْضِ سُنَّةً لِلّٰهِ تَعَالَى',
        latinNiat: 'Nawaitu sauma ayyamil bidh sunnatan lillahi ta\'ala',
        translation:
            'Aku berniat puasa sunnah Ayyamul Bidh karena Allah Ta\'ala.',
      );
    }

    // 3. Puasa Arafah (9 Dzulhijjah)
    if (hijri.hMonth == 12 && hijri.hDay == 9) {
      return FastingInfo(
        title: 'Puasa Arafah',
        subtitle: '9 Dzulhijjah',
        icon: Icons.mosque_rounded,
        arabicNiat: 'نَوَيْتُ صَوْمَ عَرَفَةَ سُنَّةً لِلّٰهِ تَعَالَى',
        latinNiat: 'Nawaitu sauma \'arafata sunnatan lillahi ta\'ala',
        translation: 'Aku berniat puasa sunnah Arafah karena Allah Ta\'ala.',
      );
    }

    // 4. Puasa Asyura (10 Muharram)
    if (hijri.hMonth == 1 && hijri.hDay == 10) {
      return FastingInfo(
        title: 'Puasa Asyura',
        subtitle: '10 Muharram',
        icon: Icons.star_rounded,
        arabicNiat: 'نَوَيْتُ صَوْمَ عَاشُورَاءَ سُنَّةً لِلّٰهِ تَعَالَى',
        latinNiat: 'Nawaitu sauma \'asyura sunnatan lillahi ta\'ala',
        translation: 'Aku berniat puasa sunnah Asyura karena Allah Ta\'ala.',
      );
    }

    return null;
  }

  /// Menghitung Jadwal Puasa Terdekat dari Hari Ini
  DateTime getNextFastingDate() {
    DateTime checkDate = DateTime.now();
    while (getFastingInfo(checkDate) == null) {
      checkDate = checkDate.add(const Duration(days: 1));
    }
    return checkDate;
  }

  /// Hitung Sisa Waktu Menuju Puasa Terdekat
  String getRemainingTime(DateTime nextDate) {
    final now = DateTime.now();
    final target = DateTime(nextDate.year, nextDate.month, nextDate.day, 4, 30);
    final difference = target.difference(now);

    if (difference.isNegative) {
      return 'Sedang Berjalan / Hari Ini';
    }

    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;
    return '$hours Jam $minutes Menit Lagi';
  }

  @override
  Widget build(BuildContext context) {
    final nextFasting = getNextFastingDate();
    final fastingTodayOrSelected = getFastingInfo(selectedDate);

    final daysInMonth =
        DateTime(currentMonth.year, currentMonth.month + 1, 0).day;
    int totalFastingDaysInMonth = 0;
    int completedThisMonth = 0;

    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(currentMonth.year, currentMonth.month, day);
      if (getFastingInfo(date) != null) {
        totalFastingDaysInMonth++;
      }
      if (completedFastingDates.any((d) =>
          d.year == date.year && d.month == date.month && d.day == date.day)) {
        completedThisMonth++;
      }
    }

    final progressValue = totalFastingDaysInMonth > 0
        ? (completedThisMonth / totalFastingDaysInMonth).clamp(0.0, 1.0)
        : 0.0;

    final isSelectedDateCompleted = completedFastingDates.any((d) =>
        d.year == selectedDate.year &&
        d.month == selectedDate.month &&
        d.day == selectedDate.day);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
        ),
        title: const Text(
          'Puasa Sunnah',
          style: TextStyle(
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            /// HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xff4A9B78), Color(0xff2E7D5A)],
                ),
                borderRadius: BorderRadius.circular(32),
              ),
              child: Column(
                children: [
                  const Icon(Icons.dark_mode_rounded,
                      color: Colors.white, size: 48),
                  const SizedBox(height: 16),
                  const Text(
                    'Puasa Berikutnya',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    DateFormat('EEEE, d MMMM', 'id_ID').format(nextFasting),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      getRemainingTime(nextFasting),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// TARGET PUASA BULANAN
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
                    'Target Puasa Bulan Ini',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 18),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: progressValue,
                      minHeight: 14,
                      backgroundColor: AppColors.secondary,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    '$completedThisMonth / $totalFastingDaysInMonth Hari Tercapai',
                    style: const TextStyle(color: AppColors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// KALENDER INTERAKTIF
            _buildCalendarSection(daysInMonth),

            const SizedBox(height: 24),

            /// NIAT PUASA & TOMBOL TANDAI SELESAI
            if (fastingTodayOrSelected != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xff4A9B78), Color(0xff2E7D5A)],
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Niat ${fastingTodayOrSelected.title}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      fastingTodayOrSelected.arabicNiat,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 1.8,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      fastingTodayOrSelected.latinNiat,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      fastingTodayOrSelected.translation,
                      style:
                          const TextStyle(color: Colors.white70, height: 1.5),
                    ),
                    const SizedBox(height: 20),

                    /// [TAMBAHAN 4] Tombol Tandai Selesai / Batalkan
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isSelectedDateCompleted
                              ? Colors.white.withOpacity(0.2)
                              : Colors.white,
                          foregroundColor: isSelectedDateCompleted
                              ? Colors.white
                              : AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () => _toggleFastingStatus(selectedDate),
                        icon: Icon(
                          isSelectedDateCompleted
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                        ),
                        label: Text(
                          isSelectedDateCompleted
                              ? 'Sudah Diselesaikan'
                              : 'Tandai Sudah Puasa',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarSection(int totalDays) {
    final firstDayWeekday =
        DateTime(currentMonth.year, currentMonth.month, 1).weekday % 7;
    final readableMonth = DateFormat('MMMM yyyy', 'id_ID').format(currentMonth);
    final daysOfWeek = ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab'];

    return Container(
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
        children: [
          Row(
            children: [
              IconButton(
                onPressed: prevMonth,
                icon: const Icon(Icons.chevron_left),
              ),
              Expanded(
                child: Text(
                  readableMonth,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                onPressed: nextMonth,
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(height: 16),

          /// [TAMBAHAN 5] Baris Header Nama Hari
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: daysOfWeek
                .map((day) => Expanded(
                      child: Text(
                        day,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 12),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: totalDays + firstDayWeekday,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              if (index < firstDayWeekday) return const SizedBox();

              final day = index - firstDayWeekday + 1;
              final date = DateTime(currentMonth.year, currentMonth.month, day);
              final isSelected = selectedDate.year == date.year &&
                  selectedDate.month == date.month &&
                  selectedDate.day == date.day;
              final fastingInfo = getFastingInfo(date);
              final isFasting = fastingInfo != null;

              // [TAMBAHAN 6] Cek apakah tanggal ini sudah diselesaikan
              final isCompleted = completedFastingDates.any((d) =>
                  d.year == date.year &&
                  d.month == date.month &&
                  d.day == date.day);

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDate = date;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? AppColors.primary
                        : (isSelected
                            ? AppColors.secondary
                            : (isFasting
                                ? const Color(0xffE8FFF1)
                                : Colors.white)),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected || isFasting
                          ? AppColors.primary
                          : Colors.grey.shade200,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        '$day',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isCompleted
                              ? Colors.white
                              : (isSelected
                                  ? AppColors.primary
                                  : AppColors.black),
                        ),
                      ),
                      if (isCompleted)
                        const Positioned(
                          top: 4,
                          right: 4,
                          child: Icon(
                            Icons.check_circle,
                            size: 10,
                            color: Colors.white,
                          ),
                        )
                      else if (isFasting)
                        const Positioned(
                          bottom: 4,
                          child: CircleAvatar(
                            radius: 3,
                            backgroundColor: AppColors.primary,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

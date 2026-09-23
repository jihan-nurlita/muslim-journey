import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:muslim_journey/core/constants/colors.dart';
import 'package:muslim_journey/pages/target/data/target_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalendarHabitPage extends StatefulWidget {
  const CalendarHabitPage({super.key});

  @override
  State<CalendarHabitPage> createState() => _CalendarHabitPageState();
}

class _CalendarHabitPageState extends State<CalendarHabitPage> {
  late DateTime _focusedDate;
  late DateTime _selectedDate;

  /// Menyimpan progres harian dari SharedPreferences
  Map<String, int> dailyProgress = {};

  final List<String> _months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];

  final List<String> _daysOfWeek = [
    'Sen',
    'Sel',
    'Rab',
    'Kam',
    'Jum',
    'Sab',
    'Min'
  ];

  @override
  void initState() {
    super.initState();
    _focusedDate = DateTime.now();
    _selectedDate = DateTime.now();
    _loadHabitData();
  }

  /// Memuat data dari SharedPreferences
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

  /// Helper untuk membuat format string kunci (YYYY-MM-DD)
  String _getDateKey(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  /// Memeriksa jumlah hitungan habit pada tanggal tertentu
  int _getCurrentCountForDate(DateTime date, String targetTitle) {
    final key = "${_getDateKey(date)}_$targetTitle";
    return dailyProgress[key] ?? 0;
  }

  /// Memeriksa apakah ada setidaknya satu aktivitas yang tercatat pada tanggal tertentu
  bool _hasActivityOnDate(DateTime date) {
    if (targetList.isEmpty) return false;
    for (var target in targetList) {
      if (_getCurrentCountForDate(date, target.title) > 0) {
        return true;
      }
    }
    return false;
  }

  int _getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  int _getFirstDayOfWeekOffset(int year, int month) {
    int weekday = DateTime(year, month, 1).weekday;
    return weekday - 1;
  }

  void _previousMonth() {
    setState(() {
      _focusedDate = DateTime(_focusedDate.year, _focusedDate.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _focusedDate = DateTime(_focusedDate.year, _focusedDate.month + 1, 1);
    });
  }

  /// Menampilkan Bottom Sheet detail aktivitas dengan UI rapi
  void _showActivityBottomSheet(DateTime date) {
    final items = targetList; // Mengambil data habit asli kamu

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          maxChildSize: 0.9,
          minChildSize: 0.4,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  // Handle Bar Bottom Sheet
                  Center(
                    child: Container(
                      width: 48,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Judul Bottom Sheet
                  const Text(
                    'Daftar Aktivitas',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${date.day} ${_months[date.month - 1]} ${date.year}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // List Aktivitas
                  Expanded(
                    child: items.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.assignment_turned_in_outlined,
                                    size: 64, color: Colors.grey.shade300),
                                const SizedBox(height: 12),
                                Text(
                                  'Tidak ada aktivitas tercatat',
                                  style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          )
                        : ListView.separated(
                            controller: scrollController,
                            itemCount: items.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 14),
                            itemBuilder: (context, index) {
                              final target = items[index];
                              final currentCount =
                                  _getCurrentCountForDate(date, target.title);
                              final isCompleted =
                                  currentCount >= target.targetCount;

                              return Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border:
                                      Border.all(color: Colors.grey.shade100),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.02),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    )
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: AppColors.secondary
                                            .withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      child: Icon(target.icon,
                                          color: AppColors.primary, size: 24),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            target.title,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '$currentCount/${target.targetCount} ${target.unit} • ${target.category}',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey.shade500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      isCompleted
                                          ? Icons.check_circle_rounded
                                          : Icons
                                              .radio_button_unchecked_rounded,
                                      color: isCompleted
                                          ? AppColors.primary
                                          : Colors.grey.shade300,
                                      size: 26,
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = _getDaysInMonth(_focusedDate.year, _focusedDate.month);
    final offset =
        _getFirstDayOfWeekOffset(_focusedDate.year, _focusedDate.month);
    final totalGridItems = daysInMonth + offset;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text(
          "Kalender Aktivitas",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
      ),
      // Menggunakan SingleChildScrollView agar jika layar kekecilan, seluruh konten bisa di-scroll rapi
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),

              /// CARD CONTROLLER KALENDER (BULAN & TAHUN)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: _previousMonth,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.arrow_back_ios_rounded,
                            size: 14, color: Colors.grey.shade700),
                      ),
                    ),
                    Text(
                      '${_months[_focusedDate.month - 1]} ${_focusedDate.year}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF222222),
                        letterSpacing: -0.5,
                      ),
                    ),
                    GestureDetector(
                      onTap: _nextMonth,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.arrow_forward_ios_rounded,
                            size: 14, color: Colors.grey.shade700),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              /// HEADER HARI
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _daysOfWeek.map((day) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        day,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 16),

              /// GRID KALENDER UTAMA (Tanpa Expanded, nempel pas di bawah Hari)
              GridView.builder(
                shrinkWrap:
                    true, // Membuat tinggi grid sesuai dengan total item kalender
                physics:
                    const NeverScrollableScrollPhysics(), // Scroll utama di-handle oleh SingleChildScrollView luar
                itemCount: totalGridItems,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  if (index < offset) {
                    return const SizedBox.shrink();
                  }

                  final dayNumber = index - offset + 1;
                  final date = DateTime(
                      _focusedDate.year, _focusedDate.month, dayNumber);

                  final isSelected = _selectedDate.year == date.year &&
                      _selectedDate.month == date.month &&
                      _selectedDate.day == date.day;

                  final isToday = DateTime.now().year == date.year &&
                      DateTime.now().month == date.month &&
                      DateTime.now().day == date.day;

                  final hasActivity = _hasActivityOnDate(date);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDate = date;
                      });
                      _showActivityBottomSheet(date);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : isToday
                                ? AppColors.secondary.withOpacity(0.7)
                                : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: isToday && !isSelected
                            ? Border.all(
                                color: AppColors.primary.withOpacity(0.3),
                                width: 1.5)
                            : Border.all(color: Colors.transparent),
                        boxShadow: [
                          if (isSelected)
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            )
                          else if (!isToday)
                            BoxShadow(
                              color: Colors.black.withOpacity(0.015),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            dayNumber.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color:
                                  isSelected ? Colors.white : AppColors.primary,
                            ),
                          ),
                          if (hasActivity) ...[
                            const SizedBox(height: 3),
                            Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.primary.withOpacity(0.4),
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                  );
                },
              ),

              /// SECTION REMINDER / MOTIVASI (Sekarang pas berada di bawah Grid Kalender)
              const _ReminderSection(),
              const SizedBox(
                  height:
                      24), // Memberikan padding bawah agar tidak terlalu mepet screen luar
            ],
          ),
        ),
      ),
    );
  }
}

class _ReminderSection extends StatefulWidget {
  const _ReminderSection();

  @override
  State<_ReminderSection> createState() => _ReminderSectionState();
}

class _ReminderSectionState extends State<_ReminderSection> {
  final List<String> quotes = [
    "Dan berbuat baiklah.sungguh,Allah menyukai orang orang yang berbuat baik.",
    "Wahai orang orang yg beriman! Berzikirlah kepada Allah dengan zikir yang sebanyak-banyaknya.",
    "Barang siapa bertakwa kepada Allah,niscaya dia akan memberikan jalan keluar baginya.",
    "Setiap kesulitan yang kamu hadapi sedang Allah ukur sesuai kemampuanmu.",
    "Sesungguhnya bersama kesulitan ada kemudahan.",
    "Jangan takut kehilangan dunia, takutlah kehilangan Allah.",
    "Allah tidak pernah meninggalkan hamba yang berharap kepada-Nya.",
    "Allah tidak membebani seseorang melainkan sesuai kesanggupannya.",
    "Jangan bersedih, Allah bersama kita.",
    "Perbanyak istighfar dan bersyukur.",
  ];

  final List<String> hadis = [
    "QS. Al-Baqarah: 195",
    "QS. Al-Ahzab: 41",
    "QS. At-Talaq: 2",
    "QS. Al-Baqarah: 286",
    "QS. Al-Insyirah: 6",
    "QS. Al-Kahfi: 46",
    "QS. Yusuf: 87",
    "QS. Al-Baqarah: 286",
    "QS. At-Taubah: 40",
    "QS. Ibrahim: 7",
  ];

  late String todayQuote;
  late String todayHadis;

  void generateQuote() {
    final random = Random();
    int index = random.nextInt(quotes.length);
    todayQuote = quotes[index];
    todayHadis = hadis[index];
  }

  @override
  void initState() {
    super.initState();
    generateQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24), // Spacing antara kalender dan card motivasi
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
            borderRadius: BorderRadius.circular(27),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Quote Islami',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                todayQuote,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                todayHadis,
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

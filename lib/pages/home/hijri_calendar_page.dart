import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:muslim_journey/core/constants/colors.dart';
import 'package:muslim_journey/models/hijri_day_model.dart';
import 'package:muslim_journey/services/hijri_calendar_service.dart';

class HijriCalendarPage extends StatefulWidget {
  final Map<String, dynamic> prayerData;

  const HijriCalendarPage({
    super.key,
    required this.prayerData,
  });

  @override
  State<HijriCalendarPage> createState() => _HijriCalendarPageState();
}

class _HijriCalendarPageState extends State<HijriCalendarPage> {
  late DateTime _currentMonth;
  late int _selectedDay;

  List<HijriDayModel> monthData = [];
  final HijriCalendarService service = HijriCalendarService();

  // Color Palette Modern Islam
  static const primaryGreen = Color(0xFF1E5E3A); // Hijau Tua (Tanggal Dipilih)
  static const lightGreen = Color(0xFFE8F5E9);
  static const accentGold = Color(0xFFD4AF37);

  Future<void> loadCalendar() async {
    try {
      final result = await service.getMonthCalendar(
        month: _currentMonth.month,
        year: _currentMonth.year,
      );

      monthData = result;

      if (_selectedDay > monthData.length) {
        _selectedDay = monthData.length;
      }

      if (!mounted) return;
      setState(() {});
    } catch (e) {
      debugPrint('ERROR API => $e');
    }
  }

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _currentMonth = DateTime(now.year, now.month);
    _selectedDay = now.day;
    loadCalendar();
  }

  void _nextMonth() async {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
    await loadCalendar();
  }

  void _prevMonth() async {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
    await loadCalendar();
  }

  int _getFirstWeekday(int year, int month) {
    return DateTime(year, month, 1).weekday % 7;
  }

  String getIslamicEvent(int hijriDay, String hijriMonth) {
    if (hijriMonth == 'Ramadan') {
      if (hijriDay == 1) return 'Awal Ramadhan';
      if (hijriDay >= 21 && hijriDay <= 29) return '10 Malam Terakhir';
      if (hijriDay == 27) return 'Malam Lailatul Qadar';
    }
    if (hijriMonth == 'Shawwal') {
      if (hijriDay == 1) return 'Hari Raya Idul Fitri';
      if (hijriDay >= 2 && hijriDay <= 7) return 'Puasa Sunnah Syawal';
    }
    if (hijriMonth == 'Dhul Hijjah') {
      if (hijriDay == 9) return 'Puasa Arafah';
      if (hijriDay == 10) return 'Hari Raya Idul Adha';
      if (hijriDay >= 11 && hijriDay <= 13) return 'Hari Tasyrik';
    }
    if (hijriMonth == 'Muharram') {
      if (hijriDay == 1) return 'Tahun Baru Hijriah';
      if (hijriDay == 10) return 'Puasa Asyura';
    }
    if (hijriMonth == "Rabi' al-Awwal" && hijriDay == 12) {
      return 'Maulid Nabi Muhammad SAW';
    }
    if (hijriMonth == 'Rajab' && hijriDay == 27) {
      return "Isra Mi'raj";
    }
    if ([13, 14, 15].contains(hijriDay)) {
      return 'Puasa Sunnah Ayyamul Bidh';
    }
    return 'Tidak ada event';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Warna adaptif tema
    final bgColor = isDark ? const Color(0xFF121212) : const Color(0xFFF3F4F6);
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final navBoxColor =
        isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF8FAFC);
    final borderColor =
        isDark ? const Color(0xFF2C2C2C) : const Color(0xFFE2E8F0);
    final darkText = isDark ? Colors.white : const Color(0xFF1F2937);
    final subText = isDark ? Colors.white54 : const Color(0xFF6B7280);

    if (monthData.isEmpty) {
      return Scaffold(
        backgroundColor: bgColor,
        body: const Center(
          child: CircularProgressIndicator(color: primaryGreen),
        ),
      );
    }

    final selectedData =
        monthData[(_selectedDay - 1).clamp(0, monthData.length - 1)];

    final readableDate = DateFormat(
      'EEEE, d MMMM yyyy',
      'id_ID',
    ).format(
      DateTime(_currentMonth.year, _currentMonth.month, _selectedDay),
    );

    final days = List.generate(monthData.length, (i) => i + 1);
    final firstWeekday =
        _getFirstWeekday(_currentMonth.year, _currentMonth.month);
    final eventName =
        getIslamicEvent(selectedData.hijriDay, selectedData.hijriMonth);
    final hasEvent = eventName != 'Tidak ada event';

    final now = DateTime.now();

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: isDark ? Colors.white : AppColors.primary,
              size: 22,
            ),
          ),
        ),
        title: Text(
          'Kalender Hijriah',
          style: TextStyle(
            color: darkText,
            fontWeight: FontWeight.w800,
            fontSize: 20,
            letterSpacing: -0.3,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: InkWell(
                onTap: () async {
                  final currentTime = DateTime.now();
                  setState(() {
                    _currentMonth =
                        DateTime(currentTime.year, currentTime.month);
                    _selectedDay = currentTime.day;
                  });
                  await loadCalendar();
                },
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        primaryGreen,
                        AppColors.primary,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: primaryGreen.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.today_rounded,
                      color: Colors.white, size: 20),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Column(
          children: [
            /// KARTU UTAMA KALENDER
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.2 : 0.03),
                    blurRadius: 20,
                    spreadRadius: 1,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  /// NAVIGASI BULAN HEADER
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: navBoxColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: borderColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildNavIconButton(
                          icon: Icons.chevron_left_rounded,
                          onTap: _prevMonth,
                          isDark: isDark,
                          darkText: darkText,
                          borderColor: borderColor,
                        ),
                        Column(
                          children: [
                            Text(
                              DateFormat('MMMM yyyy', 'en_US')
                                  .format(_currentMonth),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: darkText,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${selectedData.hijriMonth} ${selectedData.hijriYear} H',
                              style: const TextStyle(
                                fontSize: 13,
                                color: primaryGreen,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        _buildNavIconButton(
                          icon: Icons.chevron_right_rounded,
                          onTap: _nextMonth,
                          isDark: isDark,
                          darkText: darkText,
                          borderColor: borderColor,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// HEADER HARI (Min - Sab)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _DayHeader('Min', isWeekend: true),
                      _DayHeader('Sen'),
                      _DayHeader('Sel'),
                      _DayHeader('Rab'),
                      _DayHeader('Kam'),
                      _DayHeader('Jum', isJumat: true),
                      _DayHeader('Sab'),
                    ],
                  ),

                  const SizedBox(height: 12),

                  /// GRID TANGGAL KALENDER
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: days.length + firstWeekday,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.85,
                    ),
                    itemBuilder: (context, index) {
                      if (index < firstWeekday) {
                        return const SizedBox();
                      }

                      final day = days[index - firstWeekday];
                      final isSelected = _selectedDay == day;

                      final isToday = now.day == day &&
                          now.month == _currentMonth.month &&
                          now.year == _currentMonth.year;

                      Color? backgroundColor;
                      Gradient? backgroundGradient;
                      Color textColor = darkText;
                      Color subTextColor = subText;

                      if (isSelected) {
                        backgroundGradient = const LinearGradient(
                          colors: [
                            AppColors.primary,
                            AppColors.primary,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        );
                        textColor = Colors.white;
                        subTextColor = Colors.white.withOpacity(0.85);
                      } else if (isToday) {
                        backgroundColor = isDark
                            ? const Color(0xFF1B3822)
                            : const Color(0xFFE8F5E9);
                        textColor = const Color(0xFF4CAF50);
                        subTextColor = const Color(0xFF81C784);
                      } else {
                        backgroundColor = isDark
                            ? const Color(0xFF252525)
                            : const Color(0xFFFAFAFA);
                      }

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedDay = day;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: backgroundGradient,
                            color: backgroundColor,
                            border: isSelected
                                ? null
                                : Border.all(
                                    color: isToday
                                        ? AppColors.primary.withOpacity(0.4)
                                        : borderColor,
                                    width: isToday ? 1.5 : 1.0,
                                  ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color:
                                          AppColors.primary.withOpacity(0.35),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$day',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: (isSelected || isToday)
                                      ? FontWeight.bold
                                      : FontWeight.w600,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 1),
                              Text(
                                day <= monthData.length
                                    ? '${monthData[day - 1].hijriDay}'
                                    : '',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: (isSelected || isToday)
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                  color: subTextColor,
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
            ),

            const SizedBox(height: 18),

            /// DETAIL EVENT & TANGGAL (CARD BAWAH)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.2 : 0.03),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${selectedData.hijriDay} ${selectedData.hijriMonth} ${selectedData.hijriYear} H',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: darkText,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              readableDate,
                              style: TextStyle(
                                color: subText,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (hasEvent) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: accentGold.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: accentGold.withOpacity(0.4)),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.stars_rounded,
                                  color: accentGold, size: 14),
                              SizedBox(width: 4),
                              Text(
                                'Event Islam',
                                style: TextStyle(
                                  color: Color(0xFFD4AF37),
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: 16),
                  Divider(height: 1, color: borderColor),
                  const SizedBox(height: 16),

                  /// TILE CONTAINER EVENT
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: hasEvent
                          ? (isDark
                              ? const Color(0xFF1B3822)
                              : lightGreen.withOpacity(0.5))
                          : navBoxColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: hasEvent
                            ? primaryGreen.withOpacity(0.3)
                            : borderColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: hasEvent
                                ? primaryGreen
                                : (isDark
                                    ? const Color(0xFF2A2A2A)
                                    : Colors.white),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: (hasEvent ? primaryGreen : Colors.black)
                                    .withOpacity(0.08),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            hasEvent
                                ? Icons.event_available_rounded
                                : Icons.calendar_today_rounded,
                            color: hasEvent ? Colors.white : primaryGreen,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                eventName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: darkText,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                hasEvent
                                    ? 'Momen penting dalam kalender Islam'
                                    : 'Tidak ada agenda khusus hari ini',
                                style: TextStyle(
                                  color: subText,
                                  fontSize: 12,
                                ),
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
          ],
        ),
      ),
    );
  }

  Widget _buildNavIconButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool isDark,
    required Color darkText,
    required Color borderColor,
  }) {
    return Material(
      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor),
          ),
          child: Icon(icon, color: darkText, size: 20),
        ),
      ),
    );
  }
}

class _DayHeader extends StatelessWidget {
  final String text;
  final bool isWeekend;
  final bool isJumat;

  const _DayHeader(
    this.text, {
    this.isWeekend = false,
    this.isJumat = false,
  });

  @override
  Widget build(BuildContext context) {
    const textColor = Color(0xFF94A3B8);

    return SizedBox(
      width: 36,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: textColor,
          fontSize: 12,
        ),
      ),
    );
  }
}

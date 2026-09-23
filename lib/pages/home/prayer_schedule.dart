import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:muslim_journey/core/constants/colors.dart';
import 'package:muslim_journey/core/widgets/city_picker.dart';
import 'package:muslim_journey/pages/home/hijri_calendar_page.dart';
import 'package:muslim_journey/pages/qibla/qibla_page.dart';
import 'package:muslim_journey/providers/prayer_provider.dart';
import 'package:provider/provider.dart';

class PrayerSchedulePage extends StatelessWidget {
  const PrayerSchedulePage({
    super.key,
  });

  // 🕌 Helper
  String getCurrentPrayer(Map<String, dynamic> timings) {
    final now = TimeOfDay.now();

    final prayers = {
      'Subuh': timings['Fajr'],
      'Dzuhur': timings['Dhuhr'],
      'Ashar': timings['Asr'],
      'Maghrib': timings['Maghrib'],
      'Isya': timings['Isha'],
    };

    String currentPrayer = 'Subuh';

    prayers.forEach((name, time) {
      final split = time.split(':');

      final prayerTime = TimeOfDay(
        hour: int.parse(split[0]),
        minute: int.parse(split[1]),
      );

      if (now.hour >= prayerTime.hour) {
        currentPrayer = name;
      }
    });

    return currentPrayer;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PrayerProvider>();

    final prayerData = provider.prayerData as Map<String, dynamic>;

    final Map<String, dynamic> timings =
        prayerData['timings'] as Map<String, dynamic>;

    final Map<String, dynamic> gregorian =
        prayerData['date']['gregorian'] as Map<String, dynamic>;

    final Map<String, dynamic> hijri =
        prayerData['date']['hijri'] as Map<String, dynamic>;

    final rawDate = gregorian['date'];

    final parsedDate = DateFormat('dd-MM-yyyy').parse(rawDate);

    final readableDate =
        DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(parsedDate);

    final hijriDate =
        '${hijri['day']} ${hijri['month']['en']} ${hijri['year']} H';

    final activePrayer = getCurrentPrayer(timings);

    final prayers = [
      {
        'name': 'Imsak',
        'time': timings['Imsak'],
      },
      {
        'name': 'Subuh',
        'time': timings['Fajr'],
      },
      {
        'name': 'Dzuhur',
        'time': timings['Dhuhr'],
        'active': true,
      },
      {
        'name': 'Ashar',
        'time': timings['Asr'],
      },
      {
        'name': 'Maghrib',
        'time': timings['Maghrib'],
      },
      {
        'name': 'Isya',
        'time': timings['Isha'],
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,

        // ARROW BACK TANPA CONTAINER
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.primary,
              size: 22,
            ),
          ),
        ),

        title: const Text(
          'Prayer Schedule',
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: _CircleButton(
              icon: Icons.calendar_month_rounded,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HijriCalendarPage(
                      prayerData: prayerData,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            /// LOCATION CARD
            InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () {
                showCityPicker(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(24),
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
                    const Icon(
                      Icons.location_on_outlined,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        context.watch<PrayerProvider>().cityName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.grey,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 22),

            /// DATE CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff2E7D32),
                    Color(0xff2E7D32),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.18),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_today_rounded,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hijriDate,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          readableDate,
                          style: const TextStyle(
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

            const SizedBox(height: 24),

            /// PRAYER LIST
            Expanded(
              child: ListView.separated(
                itemCount: prayers.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final prayer = prayers[index];

                  return _PrayerTile(
                    name: prayer['name'] as String,
                    time: prayer['time'] as String,
                    isActive: prayer['name'] == activePrayer,
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            /// QIBLA CARD
            InkWell(
              borderRadius: BorderRadius.circular(30),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const QiblaPage(),
                  ),
                );
              },
              child: Container(
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
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Arah Kiblat',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Menghadap Utara',
                            style: TextStyle(
                              color: AppColors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 82,
                      height: 82,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xff4A9B78),
                            Color(0xff2E7D5A),
                          ],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.22),
                            blurRadius: 18,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.explore_rounded,
                        color: Colors.white,
                        size: 42,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrayerTile extends StatelessWidget {
  final String name;
  final String time;
  final bool isActive;

  const _PrayerTile({
    required this.name,
    required this.time,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: isActive
              ? AppColors.primary.withOpacity(0.18)
              : Colors.transparent,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary : AppColors.secondary,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              isActive
                  ? Icons.notifications_active_rounded
                  : Icons.notifications,
              color: isActive ? Colors.white : AppColors.primary,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isActive ? AppColors.primary : AppColors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isActive ? 'Waktu sholat saat ini' : 'Sholat berikutnya',
                  style: const TextStyle(
                    color: AppColors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isActive ? AppColors.primary : AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 20,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

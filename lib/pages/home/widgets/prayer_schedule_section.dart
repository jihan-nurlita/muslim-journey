import 'package:flutter/material.dart';
import 'package:muslim_journey/core/constants/colors.dart';
import 'package:muslim_journey/pages/home/prayer_schedule.dart';

class _PrayerScheduleSection extends StatelessWidget {
  final Map<String, dynamic> timings;
  final Map<String, dynamic> prayerData;
  final String activePrayer;
  final String cityName;

  const _PrayerScheduleSection({
    required this.timings,
    required this.prayerData,
    required this.activePrayer,
    required this.cityName,
  });

  @override
  Widget build(BuildContext context) {
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

    return Column(
      children: [
        Row(
          children: [
            const Text(
              'Jadwal Utama',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PrayerSchedulePage()),
                );
              },
              child: const Text(
                'Lihat Semua',
                style: TextStyle(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 82,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: prayers.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final prayer = prayers[index];

              final bool isActive = prayer['name'] == activePrayer;

              return Container(
                width: 86,
                decoration: BoxDecoration(
                  color: isActive ? AppColors.secondary : AppColors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      prayer['name'] as String,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      prayer['time'] as String,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

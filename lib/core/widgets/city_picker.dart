import 'package:flutter/material.dart';
import 'package:muslim_journey/core/constants/colors.dart';
import 'package:muslim_journey/core/constants/indonesia_cities.dart';
import 'package:muslim_journey/core/services/notification_service.dart';
import 'package:muslim_journey/providers/prayer_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

void showCityPicker(BuildContext context) {
  final searchController = TextEditingController();

  showDialog(
    context: context,
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setState) {
          final query = searchController.text.trim().toLowerCase();

          final filteredCities = indonesiaCities.where((city) {
            return city.toLowerCase().contains(query);
          }).toList();

          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 40,
            ),
            child: Container(
              height: 520,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Column(
                children: [
                  /// HEADER
                  Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(
                          Icons.location_on_rounded,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Text(
                          'Pilih Kota',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.close_rounded,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  /// SEARCH
                  TextField(
                    controller: searchController,
                    autofocus: false,
                    textInputAction: TextInputAction.search,
                    onChanged: (_) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      hintText: 'Cari kota...',
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: AppColors.primary,
                      ),
                      suffixIcon: searchController.text.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                searchController.clear();
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.close_rounded,
                                size: 20,
                                color: AppColors.grey,
                              ),
                            )
                          : null,
                      filled: true,
                      fillColor: AppColors.background,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: AppColors.primary,
                          width: 1.2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// LIST CITY
                  Expanded(
                    child: filteredCities.isEmpty
                        ? const Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.location_off_rounded,
                                  size: 48,
                                  color: AppColors.grey,
                                ),
                                SizedBox(height: 12),
                                Text(
                                  'Kota tidak ditemukan',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.black,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Coba gunakan nama kota lain.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.grey,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.separated(
                            itemCount: filteredCities.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final city = filteredCities[index];

                              return InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () async {
                                  final provider =
                                      context.read<PrayerProvider>();

                                  await provider.fetchPrayerTimesByCity(city);

                                  if (provider.prayerData == null) {
                                    return;
                                  }

                                  final timings =
                                      provider.prayerData!['timings']
                                          as Map<String, dynamic>;

                                  if (!kIsWeb) {
                                    await NotificationService
                                        .cancelAllNotifications();

                                    int id = 1;

                                    final prayers = {
                                      'Subuh': timings['Fajr'],
                                      'Dzuhur': timings['Dhuhr'],
                                      'Ashar': timings['Asr'],
                                      'Maghrib': timings['Maghrib'],
                                      'Isya': timings['Isha'],
                                    };

                                    for (final prayer in prayers.entries) {
                                      final split =
                                          prayer.value.toString().split(':');

                                      final now = DateTime.now();

                                      final prayerTime = DateTime(
                                        now.year,
                                        now.month,
                                        now.day,
                                        int.parse(split[0]),
                                        int.parse(split[1]),
                                      );

                                      if (prayerTime.isAfter(now)) {
                                        await NotificationService
                                            .scheduleNotification(
                                          id: id,
                                          title: 'Waktu ${prayer.key} 🕌',
                                          body:
                                              'Yuk segera tunaikan sholat ${prayer.key}',
                                          scheduledDate: prayerTime,
                                        );

                                        id++;
                                      }
                                    }
                                  }

                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(18),
                                  decoration: BoxDecoration(
                                    color: AppColors.background,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 48,
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: AppColors.secondary,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: const Icon(
                                          Icons.location_on_rounded,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: Text(
                                          city,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 16,
                                        color: AppColors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  ).then((_) {
    searchController.dispose();
  });
}

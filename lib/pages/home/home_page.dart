import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:muslim_journey/core/constants/colors.dart';
import 'package:muslim_journey/core/constants/indonesia_cities.dart';
import 'package:muslim_journey/core/services/notification_service.dart';
import 'package:muslim_journey/pages/doa/doa_page.dart';
import 'package:muslim_journey/pages/dzikir/dzikir_page.dart';
import 'package:muslim_journey/pages/habit/habit_page.dart';
import 'package:muslim_journey/pages/home/prayer_schedule.dart';
import 'package:muslim_journey/pages/notification/notification_page.dart';
import 'package:muslim_journey/pages/profile/profile_page.dart';
import 'package:muslim_journey/pages/puasa/puasa_page.dart';
import 'package:muslim_journey/pages/quran/quran_page.dart';
import 'package:muslim_journey/pages/sholat/sholat_page.dart';
import 'package:muslim_journey/pages/target/target_page.dart';
import 'package:muslim_journey/providers/prayer_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Variabel
  Timer? timer;

  String countdownText = '';

  // Helper Countdown
  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final hours = twoDigits(duration.inHours);

    final minutes = twoDigits(duration.inMinutes.remainder(60));

    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return '$hours:$minutes:$seconds';
  }

  // Function Countdown
  void startCountdown(Map<String, dynamic> timings) {
    timer?.cancel();

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        final now = DateTime.now();

        final prayers = {
          'Imsak': timings['Imsak'],
          'Subuh': timings['Fajr'],
          'Dzuhur': timings['Dhuhr'],
          'Ashar': timings['Asr'],
          'Maghrib': timings['Maghrib'],
          'Isya': timings['Isha'],
        };

        DateTime? nextPrayerTime;
        String nextPrayerName = '';

        prayers.forEach((name, time) {
          final split = time.split(':');

          final prayerTime = DateTime(
            now.year,
            now.month,
            now.day,
            int.parse(split[0]),
            int.parse(split[1]),
          );

          if (prayerTime.isAfter(now)) {
            if (nextPrayerTime == null ||
                prayerTime.isBefore(nextPrayerTime!)) {
              nextPrayerTime = prayerTime;
              nextPrayerName = name;
            }
          }
        });

        if (nextPrayerTime == null) {
          countdownText = 'Semua waktu sholat hari ini sudah lewat';
        } else {
          final difference = nextPrayerTime!.difference(now);
          countdownText = '$nextPrayerName dalam ${formatTime(difference)}';
        }

        if (mounted) {
          setState(() {});
        }
      },
    );
  }

  //
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // Helper active prayer
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

  //
  Future<void> refreshPrayerNotifications() async {
    final provider = context.read<PrayerProvider>();

    await provider.fetchPrayerTimes();

    if (provider.prayerData == null) return;

    final timings = provider.prayerData!['timings'] as Map<String, dynamic>;

    /// hapus notif lama
    await NotificationService.cancelAllNotifications();

    /// buat notif baru
    await schedulePrayerNotifications(timings);

    /// update countdown
    startCountdown(timings);
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await context.read<PrayerProvider>().fetchPrayerTimes();

      final provider = context.read<PrayerProvider>();

      if (provider.prayerData != null) {
        final timings = provider.prayerData!['timings'] as Map<String, dynamic>;

        startCountdown(timings);

        await schedulePrayerNotifications(timings);
      }
    });
  }

  Future<void> schedulePrayerNotifications(
    Map<String, dynamic> timings,
  ) async {
    final prayers = {
      'Subuh': timings['Fajr'],
      'Dzuhur': timings['Dhuhr'],
      'Ashar': timings['Asr'],
      'Maghrib': timings['Maghrib'],
      'Isya': timings['Isha'],
    };

    int id = 1;

    for (final prayer in prayers.entries) {
      final split = prayer.value.split(':');

      final now = DateTime.now();

      final prayerTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(split[0]),
        int.parse(split[1]),
      );

      if (prayerTime.isAfter(now)) {
        await NotificationService.scheduleNotification(
          id: id,
          title: 'Waktu ${prayer.key} 🕌',
          body: 'Yuk segera tunaikan sholat ${prayer.key}',
          scheduledDate: prayerTime,
        );

        id++;
      }
    }
  }

  void showCityPicker(BuildContext context) {
    final provider = context.read<PrayerProvider>();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (_) {
        return ListView.builder(
          itemCount: indonesiaCities.length,
          itemBuilder: (context, index) {
            final city = indonesiaCities[index];

            return ListTile(
              title: Text(city),
              onTap: () async {
                Navigator.pop(context);

                await provider.fetchPrayerTimesByCity(city);

                if (mounted) {
                  setState(() {});
                }
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PrayerProvider>();

    if (provider.isLoading || provider.prayerData == null) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final Map<String, dynamic> prayerData =
        provider.prayerData as Map<String, dynamic>;

    final Map<String, dynamic> timings =
        prayerData['timings'] as Map<String, dynamic>;

    final activePrayer = getCurrentPrayer(timings);

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const _BottomNavbar(
        currentIndex: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _HeaderSection(),
              const SizedBox(height: 22),

              /// PRAYER CARD
              _PrayerCard(
                prayerData: prayerData,
                timings: timings,
                countdownText: countdownText,
                activePrayer: activePrayer,
              ),

              const SizedBox(height: 24),

              /// PRAYER SCHEDULE
              _PrayerScheduleSection(
                timings: timings,
                prayerData: prayerData,
                activePrayer: activePrayer,
                cityName: provider.cityName,
              ),

              const SizedBox(height: 24),

              /// MAIN MENU
              const _MainMenuSection(),

              const SizedBox(height: 24),

              /// MOTIVATION
              const _MotivationSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.secondary,
          backgroundImage: AssetImage(
            'assets/images/profile.png',
          ),
        ),
        const SizedBox(width: 12),

        /// NAME
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Assalamualaikum',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'aisha noor',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
        ),

        /// NOTIFICATION
        Container(
          padding: const EdgeInsets.all(10),
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
          child: const Icon(
            Icons.notifications_none_rounded,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}

class _PrayerCard extends StatelessWidget {
  final Map<String, dynamic> prayerData;
  final Map<String, dynamic> timings;
  final String countdownText;
  final String activePrayer;

  const _PrayerCard({
    required this.prayerData,
    required this.timings,
    required this.countdownText,
    required this.activePrayer,
  });

  String getActivePrayerTime() {
    switch (activePrayer) {
      case 'Subuh':
        return timings['Fajr'];

      case 'Dzuhur':
        return timings['Dhuhr'];

      case 'Ashar':
        return timings['Asr'];

      case 'Maghrib':
        return timings['Maghrib'];

      case 'Isya':
        return timings['Isha'];

      default:
        return timings['Fajr'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final gregorian = prayerData['date']['gregorian'] as Map<String, dynamic>;

    final hijri = prayerData['date']['hijri'] as Map<String, dynamic>;

    final rawDate = gregorian['date'];

    final parsedDate = DateFormat('dd-MM-yyyy').parse(rawDate);

    final readableDate =
        DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(parsedDate);

    final hijriDate =
        '${hijri['day']} ${hijri['month']['en']} ${hijri['year']} H';

    return Container(
      height: 202,
      width: double.infinity,
      padding: const EdgeInsets.all(22),
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
            color: AppColors.primary.withOpacity(0.15),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
        image: const DecorationImage(
          image: AssetImage(
            'assets/icons/mousqe.png',
          ),
          alignment: Alignment.bottomRight,
          fit: BoxFit.contain,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            readableDate,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            hijriDate,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
          const Spacer(),
          Text(
            activePrayer,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            getActivePrayerTime(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 42,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            countdownText,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          )
        ],
      ),
    );
  }
}

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
                  border: Border.all(
                    color: isActive
                        ? AppColors.primary.withOpacity(0.12)
                        : Colors.transparent,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      prayer['name'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isActive ? AppColors.primary : AppColors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      prayer['time'] as String,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: isActive ? AppColors.primary : AppColors.black,
                      ),
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

class _MainMenuSection extends StatelessWidget {
  const _MainMenuSection();

  @override
  Widget build(BuildContext context) {
    final menus = [
      {
        'title': 'Quran',
        'icon': 'assets/icons/quran.png',
        'page': const QuranPage(),
      },
      {
        'title': 'Shalat',
        'icon': 'assets/icons/pray.png',
        'page': const SholatPage(),
      },
      {
        'title': 'Dzikir',
        'icon': 'assets/icons/dzikir.png',
        'page': const DzikirPage(),
      },
      {
        'title': 'Doa',
        'icon': 'assets/icons/doa.png',
        'page': const DoaPage(),
      },
      {
        'title': 'Puasa',
        'icon': 'assets/icons/calendar.png',
        'page': const PuasaPage(),
      },
      {
        'title': 'Target',
        'icon': 'assets/icons/target.png',
        'page': const TargetPage(),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Menu Utama',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: menus.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.92,
          ),
          itemBuilder: (context, index) {
            final menu = menus[index];

            return InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () {
                if (menu['page'] != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => menu['page'] as Widget,
                    ),
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      menu['icon'] as String,
                      width: 38,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      menu['title'] as String,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _MotivationSection extends StatefulWidget {
  const _MotivationSection();

  @override
  State<_MotivationSection> createState() => _MotivationSectionState();
}

class _MotivationSectionState extends State<_MotivationSection> {
  final List<String> quotes = [
    "Dan dirikanlah sholat untuk mengingat Aku.",
    "Sesungguhnya bersama kesulitan ada kemudahan.",
    "Jangan takut kehilangan dunia, takutlah kehilangan Allah.",
    "Allah tidak pernah meninggalkan hamba yang berharap kepada-Nya.",
    "Allah tidak membebani seseorang melainkan sesuai kesanggupannya.",
    "Jangan bersedih, Allah bersama kita.",
    "Perbanyak istighfar dan bersyukur.",
  ];

  final List<String> hadis = [
    "QS. Thaha: 14",
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
        const SizedBox(height: 20),
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

class _BottomNavbar extends StatelessWidget {
  final int currentIndex;

  const _BottomNavbar({
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            break;

          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const NotificationPage(),
              ),
            );
            break;

          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const HabitPage(),
              ),
            );
            break;

          case 3:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const TargetPage(),
              ),
            );
            break;

          case 4:
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const ProfilePage()));
            break;
        }
      },
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.grey,
      selectedIconTheme: const IconThemeData(
        size: 28,
      ),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.task_alt),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.track_changes_rounded),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded),
          label: '',
        ),
      ],
    );
  }
}

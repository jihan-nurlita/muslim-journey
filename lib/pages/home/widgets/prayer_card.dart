import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:muslim_journey/core/constants/colors.dart';

class _PrayerCard extends StatelessWidget {
  final Map<String, dynamic> prayerData;
  final Map<String, dynamic> timings;

  const _PrayerCard({
    required this.prayerData,
    required this.timings,
  });

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
            Color(0xff4A9B78),
            Color(0xff2E7D5A),
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
          const Text(
            'Dzuhur',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            timings['Dhuhr'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 42,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Ashar dalam 01:22:14', //Timer.periodic()
          )
        ],
      ),
    );
  }
}

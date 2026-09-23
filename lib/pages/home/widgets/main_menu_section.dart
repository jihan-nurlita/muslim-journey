import 'package:flutter/material.dart';
import 'package:muslim_journey/core/constants/colors.dart';
import 'package:muslim_journey/pages/doa/doa_page.dart';
import 'package:muslim_journey/pages/quran/quran_page.dart';
import 'package:muslim_journey/pages/sholat/sholat_page.dart';

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
      },
      {
        'title': 'Doa',
        'icon': 'assets/icons/doa.png',
        'page': const DoaPage(),
      },
      {
        'title': 'Puasa',
        'icon': 'assets/icons/calendar.png',
      },
      {
        'title': 'Target',
        'icon': 'assets/icons/target.png',
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

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:muslim_journey/pages/home/home_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController controller = PageController();

  bool isLastPage = false;

  final List<OnboardingModel> pages = const [
    OnboardingModel(
      icon: Icons.menu_book_rounded,
      title: 'Mulai Perjalanan Ibadahmu',
      description:
          'Temani setiap langkah ibadah harianmu dengan jadwal sholat, Al-Qur\'an, dzikir, dan target kebaikan.',
    ),
    OnboardingModel(
      icon: Icons.access_time_rounded,
      title: 'Jangan Lewatkan Waktu Sholat',
      description:
          'Lihat jadwal sholat sesuai lokasi dan dapatkan pengingat waktu sholat setiap hari.',
    ),
    OnboardingModel(
      icon: Icons.favorite_rounded,
      title: 'Bangun Kebiasaan Baik',
      description:
          'Pantau habit ibadah, target harian, puasa, dan progres ibadah dalam satu aplikasi.',
    ),
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // =====================================================
  // SELESAI ONBOARDING
  // =====================================================

  void finishOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const HomePage(),
      ),
    );
  }

  // =====================================================
  // NEXT PAGE
  // =====================================================

  void nextPage() {
    if (isLastPage) {
      finishOnboarding();
      return;
    }

    controller.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xff2E7D32);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            children: [
              const SizedBox(height: 16),

              // =================================================
              // SKIP
              // =================================================

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: finishOnboarding,
                  child: const Text(
                    'Lewati',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              // =================================================
              // ONBOARDING
              // =================================================

              Expanded(
                child: PageView.builder(
                  controller: controller,
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      isLastPage = index == pages.length - 1;
                    });
                  },
                  itemBuilder: (context, index) {
                    final page = pages[index];

                    return Column(
                      children: [
                        const SizedBox(height: 20),

                        // =======================================
                        // ICON / ILUSTRASI
                        // =======================================

                        Expanded(
                          flex: 6,
                          child: Center(
                            child: Container(
                              width: 230,
                              height: 230,
                              decoration: BoxDecoration(
                                color: primary.withOpacity(0.08),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Container(
                                  width: 160,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    color: primary,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: primary.withOpacity(0.20),
                                        blurRadius: 30,
                                        offset: const Offset(0, 12),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    page.icon,
                                    size: 80,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // =======================================
                        // TITLE
                        // =======================================

                        Text(
                          page.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff1E1E1E),
                            height: 1.2,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // =======================================
                        // DESCRIPTION
                        // =======================================

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: Text(
                            page.description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 15,
                              height: 1.7,
                              color: Colors.grey,
                            ),
                          ),
                        ),

                        const Spacer(),
                      ],
                    );
                  },
                ),
              ),

              // =================================================
              // PAGE INDICATOR
              // =================================================

              SmoothPageIndicator(
                controller: controller,
                count: pages.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  spacing: 8,
                  activeDotColor: primary,
                  dotColor: Colors.grey.shade300,
                ),
              ),

              const SizedBox(height: 32),

              // =================================================
              // BUTTON
              // =================================================

              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    isLastPage ? 'Mulai Sekarang' : 'Selanjutnya',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================
// ONBOARDING MODEL
// =====================================================

class OnboardingModel {
  final IconData icon;
  final String title;
  final String description;

  const OnboardingModel({
    required this.icon,
    required this.title,
    required this.description,
  });
}

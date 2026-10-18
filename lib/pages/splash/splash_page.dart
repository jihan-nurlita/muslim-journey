import 'dart:async';
import 'package:flutter/material.dart';
import 'package:muslim_journey/pages/home/home_page.dart';
import 'package:muslim_journey/pages/login/login_page.dart';
import 'package:muslim_journey/pages/onboarding/onboarding_page.dart';
import 'package:muslim_journey/services/auth_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _navigateToNext(); // Menjalankan logika pengecekan AuthService & timer 3 detik
  }

  Future<void> _navigateToNext() async {
    final bool hasSeenOnboarding = await AuthService.hasSeenOnboarding();
    final bool isLoggedIn = await AuthService.isLoggedIn();

    _timer = Timer(
      const Duration(seconds: 3),
      () {
        if (!mounted) return;

        Widget nextScreen;
        if (!hasSeenOnboarding) {
          nextScreen = const OnboardingPage();
        } else if (!isLoggedIn) {
          nextScreen = const LoginPage();
        } else {
          nextScreen = const HomePage();
        }

        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xff2E7D32);

    return Scaffold(
      backgroundColor: primary, // Tampilan latar belakang hijau penuh
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// LOGO BUKU (Desain Sebelumnya)
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.menu_book_rounded,
                  size: 60,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Muslim Journey',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Temani Perjalanan Ibadahmu',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 60),

              const SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

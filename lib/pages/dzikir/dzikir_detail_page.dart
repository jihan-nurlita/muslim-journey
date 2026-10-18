import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim_journey/core/constants/colors.dart';
import 'package:muslim_journey/pages/dzikir/models/dzikir_model.dart';

class DzikirDetailPage extends StatefulWidget {
  final DzikirModel dzikir;

  const DzikirDetailPage({
    super.key,
    required this.dzikir,
  });

  @override
  State<DzikirDetailPage> createState() => _DzikirDetailPageState();
}

class _DzikirDetailPageState extends State<DzikirDetailPage> {
  int count = 0;
  late int target;
  bool isAuto = false;
  Timer? autoTimer;

  @override
  void initState() {
    super.initState();
    target = widget.dzikir.target;
  }

  double get progress {
    if (target == 0) return 0;
    return count / target;
  }

  void incrementCounter() {
    if (count >= target) return;

    HapticFeedback.lightImpact();

    setState(() {
      count++;
    });
  }

  void resetCounter() {
    setState(() {
      count = 0;
    });
  }

  void toggleAuto() {
    if (isAuto) {
      autoTimer?.cancel();
      setState(() {
        isAuto = false;
      });
    } else {
      setState(() {
        isAuto = true;
      });

      autoTimer = Timer.periodic(
        const Duration(milliseconds: 700),
        (timer) {
          if (count >= target) {
            timer.cancel();
            setState(() {
              isAuto = false;
            });
            return;
          }

          incrementCounter();
        },
      );
    }
  }

  @override
  void dispose() {
    autoTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Mengecek apakah mode gelap sedang aktif
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.dzikir.title,
          style: TextStyle(
            color: isDark ? Colors.white : AppColors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primary,
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// CARD ARAB & ARTI
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 18,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xff1E1E1E)
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(isDark ? 0.2 : 0.03),
                                blurRadius: 12,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                widget.dzikir.arab,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.notoNaskhArabic(
                                  fontSize: 22,
                                  height: 1.8,
                                  fontWeight: FontWeight.w500,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                widget.dzikir.latin,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                widget.dzikir.meaning,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:
                                      isDark ? Colors.white54 : Colors.black54,
                                  height: 1.4,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        /// CIRCULAR COUNTER
                        Container(
                          width: 220,
                          height: 220,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isDark
                                ? const Color(0xff1E1E1E)
                                : AppColors.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary
                                    .withOpacity(isDark ? 0.15 : 0.08),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 220,
                                height: 220,
                                child: CircularProgressIndicator(
                                  value: progress,
                                  strokeWidth: 12,
                                  backgroundColor: isDark
                                      ? const Color(0xff2A2A2A)
                                      : AppColors.secondary,
                                  valueColor: const AlwaysStoppedAnimation(
                                    AppColors.primary,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '$count',
                                    style: const TextStyle(
                                      fontSize: 54,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),

                                  /// BADGE TARGET ANGKA ASLI
                                  Container(
                                    constraints: const BoxConstraints(
                                      maxWidth: 170,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? const Color(0xff2A2A2A)
                                          : AppColors.secondary,
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        'Target $target',
                                        style: const TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        /// TOMBOL TAP, REFRESH & PLAY/PAUSE
                        Column(
                          children: [
                            GestureDetector(
                              onTap: incrementCounter,
                              child: Container(
                                width: double.infinity,
                                height: 72,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xff43A36E),
                                      Color(0xff1F6B48),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: const Center(
                                  child: Text(
                                    'TAP DZIKIR +1',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: resetCounter,
                                    child: Container(
                                      height: 52,
                                      decoration: BoxDecoration(
                                        color: isDark
                                            ? const Color(0xff1E1E1E)
                                            : AppColors.white,
                                        borderRadius: BorderRadius.circular(18),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                                isDark ? 0.2 : 0.03),
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.refresh_rounded,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: toggleAuto,
                                    child: Container(
                                      height: 52,
                                      decoration: BoxDecoration(
                                        color: isAuto
                                            ? AppColors.primary
                                            : (isDark
                                                ? const Color(0xff1E1E1E)
                                                : AppColors.white),
                                        borderRadius: BorderRadius.circular(18),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                                isDark ? 0.2 : 0.03),
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        isAuto
                                            ? Icons.pause_rounded
                                            : Icons.play_arrow_rounded,
                                        color: isAuto
                                            ? Colors.white
                                            : AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

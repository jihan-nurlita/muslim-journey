import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim_journey/core/constants/colors.dart';
import 'doa_data.dart';

class DetailDoaPage extends StatelessWidget {
  final DoaModel doa;

  const DetailDoaPage({
    super.key,
    required this.doa,
  });

  @override
  Widget build(BuildContext context) {
    // Mengecek apakah mode gelap sedang aktif
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      /// APPBAR (FIX JUDUL PANJANG)
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(62),
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // TOMBOL BACK
              Positioned(
                left: 4,
                top: 0,
                bottom: 0,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.primary,
                    size: 24,
                  ),
                ),
              ),

              // JUDUL BENAR-BENAR DI TENGAH LAYAR
              Positioned(
                left: 45,
                right: 45,
                top: 4,
                bottom: 4,
                child: Center(
                  child: Text(
                    doa.judul,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.35,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : AppColors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xff1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.3)
                    : AppColors.primary.withOpacity(0.06),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER MINI
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xff2A2A2A)
                          : AppColors.background,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.menu_book_rounded,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      doa.judul,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 26),

              /// ARAB (LEBIH PREMIUM)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color:
                      isDark ? const Color(0xff2A2A2A) : AppColors.background,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    doa.arab,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.notoNaskhArabic(
                      fontSize: 23,
                      height: 2.2,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white : const Color(0xff5B4B4B),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// ARTI (ONLY)
              const Text(
                "Artinya",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 10),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color:
                      isDark ? const Color(0xff2A2A2A) : AppColors.background,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  doa.arti,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white70 : const Color(0xff7E8D85),
                    height: 1.7,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

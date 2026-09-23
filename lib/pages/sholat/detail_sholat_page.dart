import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:muslim_journey/core/constants/colors.dart';
import 'package:muslim_journey/pages/sholat/sholat_data.dart';

class DetailSholatPage extends StatelessWidget {
  final DoaModel doa;

  const DetailSholatPage({
    super.key,
    required this.doa,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      /// APPBAR (FIX JUDUL PANJANG)
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(62),
        child: Container(
          color: AppColors.background,
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
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.35,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
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
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.06),
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
                      color: AppColors.secondary,
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
                        color: Colors.black87,
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
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    doa.arab,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.notoNaskhArabic(
                      fontSize: 30,
                      height: 2.2,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff5B4B4B),
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
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  doa.arti,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff7E8D85),
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

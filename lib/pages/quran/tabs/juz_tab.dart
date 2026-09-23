import 'package:flutter/material.dart';
import 'package:muslim_journey/pages/quran/detail_surah_page.dart';
import 'package:muslim_journey/pages/quran/quran_page.dart';
import 'package:muslim_journey/pages/quran/surah.dart';

class JuzTab extends StatelessWidget {
  final List<Surah> allSurah;

  const JuzTab({
    super.key,
    required this.allSurah,
  });

  @override
  Widget build(BuildContext context) {
    /// JUZ AMMA
    final juzAmma = allSurah.where((surah) {
      return surah.nomor >= 78;
    }).toList();

    return ListView.separated(
      itemCount: juzAmma.length,
      separatorBuilder: (context, index) {
        return Divider(
          height: 1,
          color: Colors.grey.withOpacity(0),
        );
      },
      itemBuilder: (context, index) {
        final surah = juzAmma[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailSurahPage(
                  noSurat: surah.nomor,
                ),
              ),
            );
          },
          child: SurahTile(
            surahName: surah.namaLatin,
            surahNumber: surah.nomor.toString(),
            totalAyah: "${surah.jumlahAyat} Ayat",
          ),
        );
      },
    );
  }
}

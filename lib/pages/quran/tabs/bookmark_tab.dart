import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:muslim_journey/core/constants/colors.dart';
import 'package:muslim_journey/pages/quran/detail_surah_page.dart';
import 'package:muslim_journey/pages/quran/surah.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Model sederhana untuk menampung data Bookmark per Ayat
class BookmarkItemData {
  final Surah surah;
  final int ayatNomor;

  BookmarkItemData({
    required this.surah,
    required this.ayatNomor,
  });
}

class BookmarkTab extends StatefulWidget {
  final List<Surah> allSurah;

  const BookmarkTab({
    super.key,
    required this.allSurah,
  });

  @override
  State<BookmarkTab> createState() => _BookmarkTabState();
}

class _BookmarkTabState extends State<BookmarkTab> {
  List<BookmarkItemData> bookmarkedItems = [];

  @override
  void initState() {
    super.initState();
    loadBookmarks();
  }

  Future<void> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    List<BookmarkItemData> results = [];

    for (var surah in widget.allSurah) {
      final data = prefs.getString('bookmark_${surah.nomor}');

      if (data != null) {
        final List decoded = jsonDecode(data);
        for (var ayat in decoded) {
          if (ayat is int) {
            results.add(
              BookmarkItemData(
                surah: surah,
                ayatNomor: ayat,
              ),
            );
          }
        }
      }
    }

    // Mengurutkan bookmark berdasarkan nomor surah dan nomor ayat
    results.sort((a, b) {
      int comp = a.surah.nomor.compareTo(b.surah.nomor);
      if (comp != 0) return comp;
      return a.ayatNomor.compareTo(b.ayatNomor);
    });

    if (mounted) {
      setState(() {
        bookmarkedItems = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (bookmarkedItems.isEmpty) {
      return const Center(
        child: Text(
          "Belum ada bookmark",
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: bookmarkedItems.length,
      itemBuilder: (context, index) {
        final item = bookmarkedItems[index];
        final surah = item.surah;
        final ayatNomor = item.ayatNomor;

        return GestureDetector(
          onTap: () {
            // Navigasi dengan mengirimkan nomor surah DAN nomor ayat spesifik (lastAyat)
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailSurahPage(
                  noSurat: surah.nomor,
                  lastAyat:
                      ayatNomor, // Otomatis trigger auto scroll di DetailSurahPage
                ),
              ),
            ).then((_) {
              // Reload daftar bookmark ketika kembali dari DetailSurahPage
              loadBookmarks();
            });
          },
          child: Container(
            margin: const EdgeInsets.only(
              bottom: 16,
            ),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                /// NUMBER SURAH
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      surah.nomor.toString(),
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                /// NAME & AYAT DETAIL
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        surah.namaLatin,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Ayat $ayatNomor",
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const Icon(
                  Icons.bookmark,
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

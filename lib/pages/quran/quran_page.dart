import 'package:flutter/material.dart';
import 'package:muslim_journey/core/constants/colors.dart';
import 'package:muslim_journey/pages/quran/detail_surah_page.dart';
import 'package:muslim_journey/pages/quran/surah.dart';
import 'package:muslim_journey/pages/quran/tabs/bookmark_tab.dart';
import 'package:muslim_journey/pages/quran/tabs/juz_tab.dart';
import 'package:muslim_journey/services/quran_service.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({super.key});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  // ============================================================
  // DATA SURAH
  // ============================================================

  List<Surah> surahList = [];

  List<Surah> filteredSurah = [];

  // ============================================================
  // CATEGORY
  // ============================================================

  String selectedCategory = 'Surah';

  final List<String> categories = [
    'Surah',
    'Juz',
    'Bookmark',
  ];

  // ============================================================
  // INIT
  // ============================================================

  @override
  void initState() {
    super.initState();

    loadSurah();
  }

  // ============================================================
  // LOAD SURAH
  // ============================================================

  Future<void> loadSurah() async {
    try {
      final data = await QuranService.getAllSurah();

      if (!mounted) return;

      setState(() {
        surahList = data;
        filteredSurah = data;
      });
    } catch (e) {
      debugPrint('Gagal memuat daftar surah: $e');
    }
  }

  // ============================================================
  // SEARCH SURAH
  // ============================================================

  void searchSurah(String keyword) {
    final searchKeyword = keyword.trim().toLowerCase();

    if (searchKeyword.isEmpty) {
      setState(() {
        filteredSurah = surahList;
      });

      return;
    }

    final results = surahList.where((surah) {
      return surah.namaLatin.toLowerCase().contains(searchKeyword);
    }).toList();

    setState(() {
      filteredSurah = results;
    });
  }

  // ============================================================
  // CHANGE CATEGORY
  // ============================================================

  void changeCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    // ============================================================
    // LOADING
    // ============================================================

    if (surahList.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Al-Qur'an",
          style: TextStyle(
            color: AppColors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: AppColors.primary,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // ======================================================
            // SEARCH
            // ======================================================

            TextField(
              onChanged: searchSurah,
              decoration: InputDecoration(
                hintText: 'Cari Surah',
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.primary,
                ),
                filled: true,
                fillColor: Theme.of(context).cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 1.2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ======================================================
            // CATEGORY
            // ======================================================

            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];

                  final bool isSelected = selectedCategory == category;

                  return GestureDetector(
                    onTap: () {
                      changeCategory(
                        category,
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        right: 10,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.secondary,
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // ======================================================
            // CONTENT
            // ======================================================

            Expanded(
              child: _buildCategoryContent(),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // CATEGORY CONTENT
  // ============================================================

  Widget _buildCategoryContent() {
    // ============================================================
    // SURAH
    // ============================================================

    if (selectedCategory == 'Surah') {
      return _buildSurahList();
    }

    // ============================================================
    // JUZ
    // ============================================================

    if (selectedCategory == 'Juz') {
      return JuzTab(
        allSurah: surahList,
      );
    }

    // ============================================================
    // BOOKMARK
    // ============================================================

    return BookmarkTab(
      allSurah: surahList,
    );
  }

  // ============================================================
  // SURAH LIST
  // ============================================================

  Widget _buildSurahList() {
    if (filteredSurah.isEmpty) {
      return const Center(
        child: Text(
          'Surah tidak ditemukan',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(
        bottom: 24,
      ),
      itemCount: filteredSurah.length,
      itemBuilder: (context, index) {
        final surah = filteredSurah[index];

        return GestureDetector(
          onTap: () async {
            await Navigator.push(
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
            totalAyah: '${surah.jumlahAyat} Ayat',
          ),
        );
      },
    );
  }
}

// ================================================================
// SURAH TILE
// ================================================================

class SurahTile extends StatelessWidget {
  final String surahName;
  final String surahNumber;
  final String totalAyah;

  const SurahTile({
    super.key,
    required this.surahName,
    required this.surahNumber,
    required this.totalAyah,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // ======================================================
          // NOMOR SURAH
          // ======================================================

          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                surahNumber,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // ======================================================
          // NAMA SURAH
          // ======================================================

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  surahName,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  totalAyah,
                  style: const TextStyle(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),

          // ======================================================
          // ARROW
          // ======================================================

          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 18,
          ),
        ],
      ),
    );
  }
}

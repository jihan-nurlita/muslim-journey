import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslim_journey/core/constants/colors.dart';
import 'package:muslim_journey/pages/quran/ayat.dart';
import 'package:muslim_journey/pages/quran/surah.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';

class DetailSurahPage extends StatefulWidget {
  final int noSurat;
  final int? lastAyat;

  const DetailSurahPage({
    super.key,
    required this.noSurat,
    this.lastAyat,
  });

  @override
  State<DetailSurahPage> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailSurahPage> {
  // ============================================================
  // SCROLL CONTROLLER
  // ============================================================

  final ItemScrollController _itemScrollController = ItemScrollController();

  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();

  // Supaya scroll otomatis hanya dilakukan satu kali
  bool _hasInitialScrolled = false;

  // ============================================================
  // SURAH
  // ============================================================

  late int currentSurah;
  late int currentAyat;
  late Surah surah;

  late final int surahNumber;

  late Future<Surah> _surahFuture;

  // ============================================================
  // AUDIO
  // ============================================================

  late AudioPlayer _audioPlayer;

  int? _playingAyat;

  // ============================================================
  // LAST READ
  // ============================================================

  int? lastAyat;

  // ============================================================
  // BOOKMARK
  // ============================================================

  Set<int> bookmarkedAyat = {};

  // ============================================================
  // SCROLL KE LAST READ
  // ============================================================

  void _scrollToLastAyat() {
    if (lastAyat == null) return;

    // Index list dimulai dari 0.
    final targetIndex = lastAyat! - 1;

    if (targetIndex < 0) return;

    // Index 0 digunakan untuk header/detail Surah.
    final indexToScroll = targetIndex + 1;

    if (_itemScrollController.isAttached) {
      _itemScrollController.scrollTo(
        index: indexToScroll,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  // ============================================================
  // LOAD BOOKMARKS
  // ============================================================

  Future<void> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(
      'bookmark_$surahNumber',
    );

    if (data != null) {
      try {
        final List decoded = jsonDecode(data);

        if (mounted) {
          setState(() {
            bookmarkedAyat = decoded
                .map(
                  (e) => int.tryParse(e.toString()),
                )
                .whereType<int>()
                .toSet();
          });
        }
      } catch (_) {
        if (mounted) {
          setState(() {
            bookmarkedAyat = {};
          });
        }
      }
    }
  }

  // ============================================================
  // SAVE BOOKMARKS
  // ============================================================

  Future<void> _saveBookmarks() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'bookmark_$surahNumber',
      jsonEncode(
        bookmarkedAyat.toList(),
      ),
    );
  }

  // ============================================================
  // LOAD LAST READ
  // ============================================================

  Future<void> _loadLastAyat() async {
    final prefs = await SharedPreferences.getInstance();

    final int? savedSurah = prefs.getInt('last_surah');

    if (savedSurah == surahNumber) {
      if (mounted) {
        setState(() {
          lastAyat = prefs.getInt(
            'last_ayat_$surahNumber',
          );
        });
      }
    } else {
      if (mounted) {
        setState(() {
          lastAyat = null;
        });
      }
    }
  }

  // ============================================================
  // INIT STATE
  // ============================================================

  @override
  void initState() {
    super.initState();

    surahNumber = widget.noSurat;

    currentSurah = widget.noSurat;

    currentAyat = 1;

    _audioPlayer = AudioPlayer();

    _audioPlayer.onPlayerComplete.listen((event) {
      if (mounted) {
        setState(() {
          _playingAyat = null;
        });
      }
    });

    _surahFuture = _getDetailSurah();

    _loadLastAyat();

    loadBookmarks();
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    _audioPlayer.dispose();

    super.dispose();
  }

  // ============================================================
  // GLOBAL AYAT NUMBER UNTUK AUDIO
  // ============================================================

  int _globalAyatNumber(
    int surah,
    int ayat,
  ) {
    const startAyat = [
      0,
      1,
      8,
      295,
      493,
      670,
      789,
      954,
      1160,
      1236,
      1366,
      1474,
      1591,
      1707,
      1751,
      1802,
      1902,
      2029,
      2140,
      2250,
      2349,
      2483,
      2596,
      2673,
      2791,
      2856,
      2932,
      3159,
      3252,
      3341,
    ];

    return startAyat[surah - 1] + ayat;
  }

  // ============================================================
  // GET DETAIL SURAH
  // ============================================================

  Future<Surah> _getDetailSurah() async {
    final data = await Dio().get(
      "https://equran.id/api/surat/$surahNumber",
    );

    return Surah.fromJson(
      json.decode(data.toString()),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Surah>(
      future: _surahFuture,
      builder: (context, snapshot) {
        // ========================================================
        // LOADING
        // ========================================================

        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final Surah surah = snapshot.data!;

        // ========================================================
        // SCROLL AWAL
        // ========================================================

        if (snapshot.connectionState == ConnectionState.done &&
            !_hasInitialScrolled &&
            lastAyat != null) {
          _hasInitialScrolled = true;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;

            _scrollToLastAyat();
          });
        }

        // ========================================================
        // JUMLAH AYAT
        // ========================================================

        final int listAyatCount =
            surah.jumlahAyat + (surahNumber == 1 ? -1 : 0);

        // ========================================================
        // PAGE
        // ========================================================

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: _appBar(
            context: context,
            Surah: surah,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: ScrollablePositionedList.builder(
              itemScrollController: _itemScrollController,

              itemPositionsListener: _itemPositionsListener,

              // +1 untuk header/detail Surah
              itemCount: listAyatCount + 1,

              itemBuilder: (context, index) {
                // ==================================================
                // INDEX 0 = DETAIL SURAH
                // ==================================================

                if (index == 0) {
                  return _details(
                    surah: surah,
                  );
                }

                // ==================================================
                // INDEX 1 DST = AYAT
                // ==================================================

                final ayatIndex = index - 1;

                final ayat = surah.ayat!.elementAt(
                  ayatIndex + (surahNumber == 1 ? 1 : 0),
                );

                return _ayatItem(
                  ayat: ayat,
                );
              },
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // AYAT ITEM
  // ============================================================

  Widget _ayatItem({
    required Ayat ayat,
  }) {
    final bool isLastRead = ayat.nomor == lastAyat;

    final bool isPlaying = ayat.nomor == _playingAyat;

    final bool isBookmarked = bookmarkedAyat.contains(
      ayat.nomor,
    );

    return Padding(
      padding: const EdgeInsets.only(
        top: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ======================================================
          // AYAT HEADER
          // ======================================================

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: isPlaying
                  ? Colors.orange.shade700
                  : isLastRead
                      ? const Color(0xff1B5E20)
                      : const Color(0xff2E7D32),
              borderRadius: BorderRadius.circular(10),
              border: isLastRead
                  ? Border.all(
                      color: Colors.amber,
                      width: 2.5,
                    )
                  : null,
            ),
            child: Row(
              children: [
                // ==================================================
                // NOMOR AYAT
                // ==================================================

                Container(
                  width: 27,
                  height: 27,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      27 / 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '${ayat.nomor}',
                      style: GoogleFonts.poppins(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                // ==================================================
                // SHARE
                // ==================================================

                const Icon(
                  Icons.share_outlined,
                  color: Colors.white,
                ),

                const SizedBox(
                  width: 16,
                ),

                // ==================================================
                // AUDIO
                // ==================================================

                InkWell(
                  onTap: () async {
                    final globalAyat = _globalAyatNumber(
                      surahNumber,
                      ayat.nomor,
                    );

                    if (_playingAyat == ayat.nomor) {
                      await _audioPlayer.pause();

                      if (!mounted) return;

                      setState(() {
                        _playingAyat = null;
                      });
                    } else {
                      await _audioPlayer.stop();

                      await _audioPlayer.play(
                        UrlSource(
                          'https://cdn.islamic.network/quran/audio/128/ar.alafasy/$globalAyat.mp3',
                        ),
                      );

                      if (!mounted) return;

                      setState(() {
                        _playingAyat = ayat.nomor;
                      });
                    }
                  },
                  child: Icon(
                    _playingAyat == ayat.nomor
                        ? Icons.pause_circle
                        : Icons.play_circle,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(
                  width: 16,
                ),

                // ==================================================
                // BOOKMARK + LAST READ
                // ==================================================

                InkWell(
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();

                    // ----------------------------------------------
                    // 1. SIMPAN LAST READ
                    // ----------------------------------------------

                    await prefs.setInt(
                      'last_surah',
                      surahNumber,
                    );

                    await prefs.setInt(
                      'last_ayat_$surahNumber',
                      ayat.nomor,
                    );

                    // ----------------------------------------------
                    // 2. TOGGLE BOOKMARK
                    // ----------------------------------------------

                    if (bookmarkedAyat.contains(ayat.nomor)) {
                      bookmarkedAyat.remove(
                        ayat.nomor,
                      );
                    } else {
                      bookmarkedAyat.add(
                        ayat.nomor,
                      );
                    }

                    // ----------------------------------------------
                    // 3. SIMPAN BOOKMARK
                    // ----------------------------------------------

                    await prefs.setString(
                      'bookmark_$surahNumber',
                      jsonEncode(
                        bookmarkedAyat.toList(),
                      ),
                    );

                    // ----------------------------------------------
                    // 4. UPDATE STATE
                    // ----------------------------------------------

                    if (!mounted) return;

                    setState(() {
                      lastAyat = ayat.nomor;
                    });

                    // ----------------------------------------------
                    // 5. SNACKBAR
                    // ----------------------------------------------

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Terakhir dibaca disimpan: '
                          'Surah $surahNumber '
                          'Ayat ${ayat.nomor}',
                        ),
                        duration: const Duration(
                          seconds: 2,
                        ),
                      ),
                    );
                  },
                  child: Icon(
                    isBookmarked || isLastRead
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                    color: isBookmarked || isLastRead
                        ? Colors.amber
                        : Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // ======================================================
          // SEDANG DIPUTAR
          // ======================================================

          if (isPlaying)
            Padding(
              padding: const EdgeInsets.only(
                top: 6,
              ),
              child: Text(
                'Sedang diputar',
                style: GoogleFonts.poppins(
                  color: Colors.orange,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

          // ======================================================
          // TERAKHIR DIBACA
          // ======================================================

          if (isLastRead)
            Padding(
              padding: const EdgeInsets.only(
                top: 6,
              ),
              child: Text(
                'Terakhir dibaca',
                style: GoogleFonts.poppins(
                  color: Colors.amber,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

          const SizedBox(
            height: 24,
          ),

          // ======================================================
          // ARAB
          // ======================================================

          Text(
            ayat.ar,
            style: GoogleFonts.scheherazadeNew(
              color: const Color(0xff5B4B4B),
              height: 2.2,
              fontWeight: FontWeight.w500,
              fontSize: 23,
            ),
            textAlign: TextAlign.right,
          ),

          const SizedBox(
            height: 16,
          ),

          // ======================================================
          // TERJEMAHAN
          // ======================================================

          Text(
            ayat.idn,
            style: GoogleFonts.poppins(
              color: const Color(0xff7E8D85),
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DETAIL SURAH
  // ============================================================

  Widget _details({
    required Surah surah,
  }) =>
      Padding(
        padding: const EdgeInsets.only(
          bottom: 12,
        ),
        child: SizedBox(
          height: 250,
          child: Stack(
            children: [
              // ==================================================
              // BACKGROUND CARD
              // ==================================================

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  gradient: LinearGradient(
                    colors: [
                      const Color(
                        0xffE8F5E9,
                      ),
                      const Color(
                        0xffE8F5E9,
                      ).withOpacity(0.80),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),

              // ==================================================
              // MASJID
              // ==================================================

              Positioned(
                right: -55,
                child: Opacity(
                  opacity: .10,
                  child: Image.asset(
                    'assets/images/mesjid.png',
                    width: 258,
                  ),
                ),
              ),

              // ==================================================
              // CONTENT
              // ==================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(
                  28,
                ),
                child: Column(
                  children: [
                    // ============================================
                    // NAMA SURAH
                    // ============================================

                    Text(
                      surah.namaLatin,
                      style: GoogleFonts.poppins(
                        color: Theme.of(
                          context,
                        ).textTheme.bodyLarge!.color,
                        fontWeight: FontWeight.w500,
                        fontSize: 26,
                      ),
                    ),

                    const SizedBox(
                      height: 4,
                    ),

                    // ============================================
                    // ARTI
                    // ============================================

                    Text(
                      surah.arti,
                      style: GoogleFonts.poppins(
                        color: const Color(
                          0xff8D8D8D,
                        ),
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),

                    // ============================================
                    // DIVIDER
                    // ============================================

                    Divider(
                      color: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.color,
                      thickness: 2,
                      height: 35,
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    // ============================================
                    // TEMPAT TURUN + JUMLAH AYAT
                    // ============================================

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          surah.tempatTurun.name,
                          style: GoogleFonts.poppins(
                            color: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              2,
                            ),
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${surah.jumlahAyat} Ayat",
                          style: GoogleFonts.poppins(
                            color: const Color(
                              0xff8D8D8D,
                            ),
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    // ============================================
                    // LAFADZ
                    // ============================================

                    Image.asset(
                      'assets/images/lafadz.png',
                      color: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.color,
                      width: 225,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  // ============================================================
  // APP BAR
  // ============================================================

  AppBar _appBar({
    required BuildContext context,
    required Surah Surah,
  }) =>
      AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ==================================================
              // BACK BUTTON
              // ==================================================

              IconButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(
                width: 8,
              ),

              // ==================================================
              // NAMA SURAH
              // ==================================================

              Text(
                Surah.namaLatin,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Spacer(),

              // ==================================================
              // SEARCH
              // ==================================================

              IconButton(
                onPressed: () {},
                icon: Image.asset(
                  'assets/images/search.png',
                  color: AppColors.primary,
                  width: 19,
                ),
              ),
            ],
          ),
        ),
      );
}

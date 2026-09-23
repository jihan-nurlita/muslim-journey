// import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:muslim_journey/pages/quran/surah.dart';

class QuranService {
  static Future<List<Surah>> getAllSurah() async {
    final String response = await rootBundle.loadString(
      'assets/json/surah.json',
    );

    final data = surahFromJson(response);

    return data;
  }
}

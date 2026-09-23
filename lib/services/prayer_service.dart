import 'dart:convert';

import 'package:http/http.dart' as http;

class PrayerService {
  static Future<Map<String, dynamic>> getPrayerTimes() async {
    final response = await http.get(
      Uri.parse(
        'https://api.aladhan.com/v1/timingsByCity?city=Jakarta&country=Indonesia&method=20',
      ),
    );

    final data = jsonDecode(response.body);

    return data['data'];
  }
}

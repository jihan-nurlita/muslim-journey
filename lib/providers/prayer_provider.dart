import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:muslim_journey/services/prayer_service.dart';

class PrayerProvider extends ChangeNotifier {
  String cityName = 'Jakarta';

  bool isLoading = false;

  Map<String, dynamic>? prayerData;

  //
  Future<void> fetchPrayerTimesByCity(String city) async {
    try {
      isLoading = true;
      notifyListeners();

      cityName = city;

      final response = await Dio().get(
        'https://api.aladhan.com/v1/timingsByCity?city=$city&country=Indonesia&method=11',
      );

      prayerData = response.data['data'];

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }

  //
  Future<void> fetchPrayerTimes() async {
    isLoading = true;
    notifyListeners();

    try {
      final data = await PrayerService.getPrayerTimes();

      prayerData = data;
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }
}

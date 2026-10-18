import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:muslim_journey/services/prayer_service.dart';
import 'package:shared_preferences/shared_preferences.dart'; // 1. Import shared_preferences

class PrayerProvider extends ChangeNotifier {
  String cityName = 'Kuningan';
  bool isLoading = false;
  Map<String, dynamic>? prayerData;

  PrayerProvider() {
    loadSavedCity(); // 2. Muat kota tersimpan saat Provider pertama kali dijalankan
  }

  // Memuat kota yang terakhir dipilih dari SharedPreferences
  Future<void> loadSavedCity() async {
    final prefs = await SharedPreferences.getInstance();
    final savedCity = prefs.getString('selected_city');
    if (savedCity != null && savedCity.isNotEmpty) {
      cityName = savedCity;
    }
    // Langsung ambil jadwal sholat berdasarkan kota yang dimuat
    await fetchPrayerTimesByCity(cityName);
  }

  // Mengambil jadwal sholat berdasarkan kota & menyimpannya
  Future<void> fetchPrayerTimesByCity(String city) async {
    try {
      isLoading = true;
      notifyListeners();

      cityName = city;

      // 3. Simpan kota pilihan ke SharedPreferences secara permanen
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('selected_city', city);

      final response = await Dio().get(
        'https://api.aladhan.com/v1/timingsByCity?city=$city&country=Indonesia&method=11',
      );

      prayerData = response.data['data'];

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      debugPrint(e.toString());
    }
  }

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

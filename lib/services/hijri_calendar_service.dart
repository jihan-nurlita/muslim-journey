import 'package:dio/dio.dart';
import '../models/hijri_day_model.dart';

class HijriCalendarService {
  final Dio dio = Dio();

  Future<List<HijriDayModel>> getMonthCalendar({
    required int month,
    required int year,
  }) async {
    final response = await dio.get(
      'https://api.aladhan.com/v1/gToHCalendar/$month/$year',
    );

    final data = response.data['data'] as List;

    return data
        .map(
          (e) => HijriDayModel.fromJson(e),
        )
        .toList();
  }
}

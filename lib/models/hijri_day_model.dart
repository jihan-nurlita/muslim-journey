class HijriDayModel {
  final int gregorianDay;

  final int hijriDay;

  final String hijriMonth;

  final String hijriYear;

  HijriDayModel({
    required this.gregorianDay,
    required this.hijriDay,
    required this.hijriMonth,
    required this.hijriYear,
  });

  factory HijriDayModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return HijriDayModel(
      gregorianDay: int.parse(
        json['gregorian']['day'],
      ),
      hijriDay: int.parse(
        json['hijri']['day'],
      ),
      hijriMonth: json['hijri']['month']['en'],
      hijriYear: json['hijri']['year'],
    );
  }
}

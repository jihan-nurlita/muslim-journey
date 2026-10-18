import 'package:flutter/material.dart';

class TargetModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final String category;
  final String frequency;
  final bool reminderEnabled;
  final int reminderHour;
  final int reminderMinute;
  final int targetCount;
  final List<String> activeDays;
  final String unit;

  TargetModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.category,
    required this.frequency,
    required this.reminderEnabled,
    required this.reminderHour,
    required this.reminderMinute,
    required this.targetCount,
    required this.activeDays,
    required this.unit,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'iconCode': icon.codePoint,
      'iconFontFamily': icon.fontFamily,
      'category': category,
      'frequency': frequency,
      'reminderEnabled': reminderEnabled,
      'reminderHour': reminderHour,
      'reminderMinute': reminderMinute,
      'targetCount': targetCount,
      'activeDays': activeDays,
      'unit': unit,
    };
  }

  factory TargetModel.fromJson(Map<String, dynamic> json) {
    return TargetModel(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      icon: IconData(
        json['iconCode'] ?? Icons.mosque_rounded.codePoint,
        fontFamily: json['iconFontFamily'] ?? 'MaterialIcons',
      ),
      category: json['category'] ?? '',
      frequency: json['frequency'] ?? '',
      reminderEnabled: json['reminderEnabled'] ?? false,
      reminderHour: json['reminderHour'] ?? 0,
      reminderMinute: json['reminderMinute'] ?? 0,
      targetCount: json['targetCount'] ?? 1,
      activeDays: List<String>.from(json['activeDays'] ?? []),
      unit: json['unit'] ?? '',
    );
  }
}

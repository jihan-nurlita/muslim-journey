import 'package:flutter/material.dart';

class TargetModel {
  final String title;

  final String subtitle;

  final IconData icon;

  final String category;

  final String frequency;

  bool reminderEnabled;

  final int reminderHour;

  final int reminderMinute;

  final List<String> activeDays;

  int targetCount;

  int currentCount;

  String unit;

  bool isDone;

  final Map<String, bool> history;

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
    this.currentCount = 0,
    required this.unit,
    this.isDone = false,
    this.history = const {},
  });

  double get progress {
    if (targetCount == 0) return 0;

    return currentCount / targetCount;
  }

  bool get isCompleted {
    return currentCount >= targetCount;
  }

  void incrementProgress() {
    if (currentCount < targetCount) {
      currentCount++;

      if (currentCount >= targetCount) {
        isDone = true;
      }
    }
  }

  void decrementProgress() {
    if (currentCount > 0) {
      currentCount--;

      isDone = false;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'icon': icon.codePoint,
      'category': category,
      'frequency': frequency,
      'reminderEnabled': reminderEnabled,
      'reminderHour': reminderHour,
      'reminderMinute': reminderMinute,
      'targetCount': targetCount,
      'currentCount': currentCount,
      'activeDays': activeDays,
      'unit': unit,
      'isDone': isDone,
      'history': history,
    };
  }

  factory TargetModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return TargetModel(
      title: json['title'],
      subtitle: json['subtitle'],
      icon: IconData(
        json['icon'],
        fontFamily: 'MaterialIcons',
      ),
      category: json['category'],
      frequency: json['frequency'],
      reminderEnabled: json['reminderEnabled'],
      reminderHour: json['reminderHour'],
      reminderMinute: json['reminderMinute'],
      targetCount: json['targetCount'],
      activeDays: List<String>.from(
        json['activeDays'] ?? [],
      ),
      currentCount: json['currentCount'] ?? 0,
      unit: json['unit'] ?? 'kali',
      isDone: json['isDone'] ?? false,
      history: Map<String, bool>.from(
        json['history'] ?? {},
      ),
    );
  }

  TargetModel copyWith({
    bool? reminderEnabled,
  }) {
    return TargetModel(
      title: title,
      subtitle: subtitle,
      icon: icon,
      category: category,
      frequency: frequency,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      reminderHour: reminderHour,
      reminderMinute: reminderMinute,
      targetCount: targetCount,
      activeDays: activeDays,
      currentCount: currentCount,
      unit: unit,
      isDone: isDone,
      history: history,
    );
  }
}

import 'package:flutter/material.dart';

class DzikirModel {
  final String title;
  final String arab;
  final String latin;
  final String meaning;
  final int target;
  final IconData icon;
  final bool isCustom;

  DzikirModel({
    required this.title,
    required this.arab,
    required this.latin,
    required this.meaning,
    required this.target,
    required this.icon,
    this.isCustom = false,
  });

  DzikirModel copyWith({
    String? title,
    String? arab,
    String? latin,
    String? meaning,
    int? target,
    IconData? icon,
    bool? isCustom,
  }) {
    return DzikirModel(
      title: title ?? this.title,
      arab: arab ?? this.arab,
      latin: latin ?? this.latin,
      meaning: meaning ?? this.meaning,
      target: target ?? this.target,
      icon: icon ?? this.icon,
      isCustom: isCustom ?? this.isCustom,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'arab': arab,
      'latin': latin,
      'meaning': meaning,
      'target': target,
      'isCustom': isCustom,
    };
  }

  factory DzikirModel.fromJson(Map<String, dynamic> json) {
    return DzikirModel(
      title: json['title'],
      arab: json['arab'],
      latin: json['latin'],
      meaning: json['meaning'],
      target: json['target'],
      icon: Icons.auto_awesome_rounded,
      isCustom: json['isCustom'] ?? false,
    );
  }
}

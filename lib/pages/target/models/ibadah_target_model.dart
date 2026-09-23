import 'package:flutter/material.dart';

class IbadahTargetModel {
  final String title;
  final String subtitle;
  final IconData icon;
  bool isDone;

  IbadahTargetModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.isDone = false,
  });
}

import 'package:flutter/material.dart';

import '../models/target_model.dart';

List<TargetModel> targetList = [
  TargetModel(
    title: 'Sholat Tahajud',
    subtitle: 'Rutinitas malam',
    icon: Icons.nightlight_round,
    category: 'Sholat',
    frequency: 'Harian',
    reminderEnabled: true,
    reminderHour: 4,
    reminderMinute: 30,
    targetCount: 1,
    currentCount: 0,
    unit: 'Tidak Ada',
    activeDays: [
      'Sen',
      'Sel',
      'Rab',
      'Kam',
      'Jum',
      'Sab',
      'Min',
    ],
  ),
  TargetModel(
    title: 'Baca Quran',
    subtitle: 'Minimal 1 halaman',
    icon: Icons.menu_book_rounded,
    category: 'Quran',
    frequency: 'Harian',
    reminderEnabled: true,
    reminderHour: 5,
    reminderMinute: 30,
    targetCount:
        1, // Diubah ke 3 agar sesuai dengan subtitle "Minimal 3 halaman"
    currentCount: 0,
    unit: 'halaman',
    activeDays: [
      'Sen',
      'Sel',
      'Rab',
      'Kam',
      'Jum',
      'Sab',
      'Min',
    ],
  ),
  TargetModel(
    title: 'Dzikir Pagi',
    subtitle: 'Dzikir setelah Subuh',
    icon: Icons.favorite_rounded,
    category: 'Dzikir',
    frequency: 'Harian',
    reminderEnabled: true,
    reminderHour: 5,
    reminderMinute: 30,
    targetCount: 1,
    currentCount: 0, // Ditambahkan agar konsisten
    unit: 'kali', // Diisi 'kali' agar UI tidak kosong
    activeDays: [
      'Sen',
      'Sel',
      'Rab',
      'Kam',
      'Jum',
      'Sab',
      'Min',
    ],
  ),
  TargetModel(
    title: 'Puasa Senin Kamis',
    subtitle: 'Puasa sunnah',
    icon: Icons.star_rounded,
    category: 'Puasa',
    frequency: 'Mingguan',
    reminderEnabled: true,
    reminderHour: 3,
    reminderMinute: 30,
    targetCount: 1,
    unit: '',
    activeDays: [
      'Sen',
      'Kam',
    ],
  ),
];

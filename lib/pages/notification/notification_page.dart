import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:muslim_journey/core/constants/colors.dart';
import 'package:muslim_journey/pages/habit/habit_page.dart';
import 'package:muslim_journey/pages/home/home_page.dart';
import 'package:muslim_journey/pages/profile/profile_page.dart';
import 'package:muslim_journey/pages/target/target_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<ReminderModel> reminders = [];

  final List<String> dayNames = [
    'Sen',
    'Sel',
    'Rab',
    'Kam',
    'Jum',
    'Sab',
    'Min',
  ];

  @override
  void initState() {
    super.initState();

    clearOldData();
    loadReminders();
  }

  Future<void> clearOldData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('reminders');
  }

  Future<void> loadReminders() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString('reminders');

    if (data != null) {
      final decoded = jsonDecode(data) as List;

      reminders = decoded.map((e) {
        return ReminderModel.fromJson(e);
      }).toList();
    } else {
      reminders = [
        ReminderModel(
          title: 'Sholat Subuh',
          time: '04:35',
          isActive: true,
          repeatType: 'every_day',
          selectedDays: [1, 2, 3, 4, 5, 6, 7],
        ),
        ReminderModel(
          title: 'Puasa Senin Kamis',
          time: '03:30',
          isActive: true,
          repeatType: 'custom',
          selectedDays: [1, 4],
        ),
      ];
    }

    setState(() {});
  }

  Future<void> saveReminders() async {
    final prefs = await SharedPreferences.getInstance();

    final encoded = jsonEncode(
      reminders.map((e) => e.toJson()).toList(),
    );

    await prefs.setString(
      'reminders',
      encoded,
    );
  }

  String formatDays(List<int> days) {
    if (days.length == 7) {
      return 'Setiap hari';
    }

    return days.map((e) {
      return dayNames[e - 1];
    }).join(', ');
  }

  void addReminder() {
    final titleController = TextEditingController();

    TimeOfDay selectedTime = TimeOfDay.now();

    String repeatType = 'every_day';

    List<int> selectedDays = [
      1,
      2,
      3,
      4,
      5,
      6,
      7,
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Tambah Reminder',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    /// TITLE
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: 'Nama reminder',
                        filled: true,
                        fillColor: AppColors.background,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    /// TIME
                    InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () async {
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: selectedTime,
                        );

                        if (picked != null) {
                          setModalState(() {
                            selectedTime = picked;
                          });
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              selectedTime.format(context),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// REPEAT TITLE
                    const Text(
                      'Repeat',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 14),

                    /// EVERY DAY
                    GestureDetector(
                      onTap: () {
                        setModalState(() {
                          repeatType = 'every_day';

                          selectedDays = [
                            1,
                            2,
                            3,
                            4,
                            5,
                            6,
                            7,
                          ];
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: repeatType == 'every_day'
                              ? AppColors.primary.withOpacity(0.1)
                              : AppColors.background,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: repeatType == 'every_day'
                                ? AppColors.primary
                                : Colors.transparent,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.repeat,
                              color: repeatType == 'every_day'
                                  ? AppColors.primary
                                  : Colors.grey,
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'Setiap Hari',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            if (repeatType == 'every_day')
                              const Icon(
                                Icons.check_circle,
                                color: AppColors.primary,
                              ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    /// CUSTOM DAYS
                    GestureDetector(
                      onTap: () {
                        setModalState(() {
                          repeatType = 'custom';

                          selectedDays = [];
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: repeatType == 'custom'
                              ? AppColors.primary.withOpacity(0.1)
                              : AppColors.background,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: repeatType == 'custom'
                                ? AppColors.primary
                                : Colors.transparent,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  color: repeatType == 'custom'
                                      ? AppColors.primary
                                      : Colors.grey,
                                ),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Text(
                                    'Pilih Hari',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                if (repeatType == 'custom')
                                  const Icon(
                                    Icons.check_circle,
                                    color: AppColors.primary,
                                  ),
                              ],
                            ),
                            if (repeatType == 'custom') ...[
                              const SizedBox(height: 18),
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: List.generate(
                                  7,
                                  (index) {
                                    final day = index + 1;

                                    final isSelected =
                                        selectedDays.contains(day);

                                    return GestureDetector(
                                      onTap: () {
                                        setModalState(() {
                                          if (isSelected) {
                                            selectedDays.remove(day);
                                          } else {
                                            selectedDays.add(day);
                                          }
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? AppColors.primary
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          border: Border.all(
                                            color: isSelected
                                                ? AppColors.primary
                                                : Colors.grey.shade300,
                                          ),
                                        ),
                                        child: Text(
                                          dayNames[index],
                                          style: TextStyle(
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    /// SAVE BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: () async {
                          if (titleController.text.trim().isEmpty) {
                            return;
                          }

                          if (selectedDays.isEmpty) {
                            return;
                          }

                          final hour =
                              selectedTime.hour.toString().padLeft(2, '0');

                          final minute =
                              selectedTime.minute.toString().padLeft(2, '0');

                          reminders.add(
                            ReminderModel(
                              title: titleController.text,
                              time: '$hour:$minute',
                              isActive: true,
                              repeatType: repeatType,
                              selectedDays: selectedDays,
                            ),
                          );

                          await saveReminders();

                          setState(() {});

                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Simpan',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void deleteReminder(int index) async {
    reminders.removeAt(index);

    await saveReminders();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const _BottomNavbar(
        currentIndex: 1,
      ),
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Reminder',
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: AppColors.black,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: addReminder,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: reminders.isEmpty
          ? const Center(
              child: Text(
                'Belum ada reminder',
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(18),
              itemCount: reminders.length,
              itemBuilder: (context, index) {
                final reminder = reminders[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(
                          Icons.notifications_active_rounded,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reminder.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              reminder.time,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.grey,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              formatDays(reminder.selectedDays),
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Switch(
                            value: reminder.isActive,
                            activeColor: AppColors.primary,
                            onChanged: (value) async {
                              setState(() {
                                reminder.isActive = value;
                              });

                              await saveReminders();
                            },
                          ),
                          IconButton(
                            onPressed: () {
                              deleteReminder(index);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class ReminderModel {
  String title;
  String time;
  bool isActive;

  /// every_day / custom
  String repeatType;

  /// Senin=1 ... Minggu=7
  List<int> selectedDays;

  ReminderModel({
    required this.title,
    required this.time,
    required this.isActive,
    required this.repeatType,
    required this.selectedDays,
  });

  factory ReminderModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ReminderModel(
      title: json['title'] ?? '',
      time: json['time'] ?? '',
      isActive: json['isActive'] ?? false,
      repeatType: json['repeatType'] ?? 'every_day',
      selectedDays: json['selectedDays'] != null
          ? List<int>.from(
              json['selectedDays'],
            )
          : [1, 2, 3, 4, 5, 6, 7],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'time': time,
      'isActive': isActive,
      'repeatType': repeatType,
      'selectedDays': selectedDays,
    };
  }
}

class _BottomNavbar extends StatelessWidget {
  final int currentIndex;

  const _BottomNavbar({
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          /// HOME
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const HomePage(),
              ),
            );
            break;

          /// NITICATION
          case 1:
            break;

          /// Habit
          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const HabitPage(),
              ),
            );
            break;

          /// TARGET
          case 3:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => const TargetPage(),
              ),
            );
            break;

          /// PROFILE
          case 4:
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const ProfilePage()));
            break;
        }
      },
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.grey,
      selectedIconTheme: const IconThemeData(
        size: 28,
      ),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.task_alt),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.track_changes_rounded),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded),
          label: '',
        ),
      ],
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:muslim_journey/core/constants/colors.dart';
import 'package:muslim_journey/services/notification_service.dart';
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
    loadReminders();
  }

  /// MEMUAT DATA REMINDER DARI LOCAL STORAGE (SharedPreferences)
  Future<void> loadReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('reminders');

    if (data != null && data.isNotEmpty) {
      final decoded = jsonDecode(data) as List;
      setState(() {
        reminders = decoded.map((e) {
          return ReminderModel.fromJson(e);
        }).toList();
      });
    } else {
      setState(() {
        reminders = [
          ReminderModel(
            id: 1,
            title: 'Sholat Subuh',
            time: '04:35',
            isActive: true,
            repeatType: 'every_day',
            selectedDays: [1, 2, 3, 4, 5, 6, 7],
          ),
          ReminderModel(
            id: 2,
            title: 'Puasa Senin Kamis',
            time: '03:30',
            isActive: true,
            repeatType: 'custom',
            selectedDays: [1, 4],
          ),
        ];
      });
      await saveReminders();
    }
  }

  /// MENYIMPAN DATA REMINDER KE LOCAL STORAGE
  Future<void> saveReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(
      reminders.map((e) => e.toJson()).toList(),
    );
    await prefs.setString('reminders', encoded);
  }

  String formatDays(List<int> days) {
    if (days.length == 7) {
      return 'Setiap hari';
    }
    if (days.isEmpty) {
      return 'Tidak ada hari dipilih';
    }

    return days.map((e) {
      return dayNames[e - 1];
    }).join(', ');
  }

  /// POP-UP KONFIRMASI HAPUS
  Future<bool?> showDeleteConfirmationDialog(BuildContext context) async {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDark ? const Color(0xff1E1E1E) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Text(
            'Hapus Reminder',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          content: Text(
            'Apakah kamu yakin ingin menghapus reminder ini?',
            style: TextStyle(color: isDark ? Colors.white54 : AppColors.grey),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Batal
              },
              child: const Text(
                'Batal',
                style: TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(true); // Konfirmasi Hapus
              },
              child: const Text(
                'Hapus',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// MODAL TAMBAH / EDIT REMINDER
  void addOrEditReminder({ReminderModel? existingReminder, int? editIndex}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleController = TextEditingController(
      text: existingReminder?.title ?? '',
    );

    TimeOfDay selectedTime = TimeOfDay.now();
    if (existingReminder != null) {
      final parts = existingReminder.time.split(':');
      selectedTime = TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      );
    }

    String repeatType = existingReminder?.repeatType ?? 'every_day';
    List<int> selectedDays = existingReminder?.selectedDays != null
        ? List.from(existingReminder!.selectedDays)
        : [1, 2, 3, 4, 5, 6, 7];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xff1E1E1E) : Colors.white,
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
                    Center(
                      child: Text(
                        existingReminder == null
                            ? 'Tambah Reminder'
                            : 'Edit Reminder',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    /// TITLE
                    TextField(
                      controller: titleController,
                      style: TextStyle(
                          color: isDark ? Colors.white : Colors.black87),
                      decoration: InputDecoration(
                        hintText: 'Nama reminder',
                        hintStyle: TextStyle(
                            color: isDark ? Colors.white38 : Colors.grey),
                        filled: true,
                        fillColor: isDark
                            ? const Color(0xff2A2A2A)
                            : AppColors.background,
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
                          color: isDark
                              ? const Color(0xff2A2A2A)
                              : AppColors.background,
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
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    /// REPEAT TITLE
                    Text(
                      'Repeat',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 14),

                    /// EVERY DAY
                    GestureDetector(
                      onTap: () {
                        setModalState(() {
                          repeatType = 'every_day';
                          selectedDays = [1, 2, 3, 4, 5, 6, 7];
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: repeatType == 'every_day'
                              ? AppColors.primary.withOpacity(0.1)
                              : (isDark
                                  ? const Color(0xff2A2A2A)
                                  : AppColors.background),
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
                            Expanded(
                              child: Text(
                                'Setiap Hari',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? Colors.white : Colors.black87,
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
                              : (isDark
                                  ? const Color(0xff2A2A2A)
                                  : AppColors.background),
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
                                Expanded(
                                  child: Text(
                                    'Pilih Hari',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: isDark
                                          ? Colors.white
                                          : Colors.black87,
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
                                              : (isDark
                                                  ? const Color(0xff1E1E1E)
                                                  : Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          border: Border.all(
                                            color: isSelected
                                                ? AppColors.primary
                                                : (isDark
                                                    ? Colors.white24
                                                    : Colors.grey.shade300),
                                          ),
                                        ),
                                        child: Text(
                                          dayNames[index],
                                          style: TextStyle(
                                            color: isSelected
                                                ? Colors.white
                                                : (isDark
                                                    ? Colors.white
                                                    : Colors.black),
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
                          if (titleController.text.trim().isEmpty) return;
                          if (selectedDays.isEmpty) return;

                          final hour = selectedTime.hour;
                          final minute = selectedTime.minute;

                          final formattedHour = hour.toString().padLeft(2, '0');
                          final formattedMinute =
                              minute.toString().padLeft(2, '0');
                          final timeString = '$formattedHour:$formattedMinute';

                          if (existingReminder == null) {
                            final int notificationId =
                                DateTime.now().millisecondsSinceEpoch ~/ 1000;

                            setState(() {
                              reminders.add(
                                ReminderModel(
                                  id: notificationId,
                                  title: titleController.text.trim(),
                                  time: timeString,
                                  isActive: true,
                                  repeatType: repeatType,
                                  selectedDays: selectedDays,
                                ),
                              );
                            });

                            await NotificationService.scheduleDailyNotification(
                              id: notificationId,
                              title: "Waktunya ${titleController.text.trim()}!",
                              body:
                                  "Yuk, segera tunaikan habit dan ibadahmu hari ini.",
                              hour: hour,
                              minute: minute,
                            );
                          } else {
                            await NotificationService.cancelNotification(
                                existingReminder.id);

                            setState(() {
                              reminders[editIndex!] = ReminderModel(
                                id: existingReminder.id,
                                title: titleController.text.trim(),
                                time: timeString,
                                isActive: existingReminder.isActive,
                                repeatType: repeatType,
                                selectedDays: selectedDays,
                              );
                            });

                            if (existingReminder.isActive) {
                              await NotificationService
                                  .scheduleDailyNotification(
                                id: existingReminder.id,
                                title:
                                    "Waktunya ${titleController.text.trim()}!",
                                body:
                                    "Yuk, segera tunaikan habit dan ibadahmu hari ini.",
                                hour: hour,
                                minute: minute,
                              );
                            }
                          }

                          await saveReminders();
                          if (mounted) Navigator.pop(context);
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
    final reminder = reminders[index];
    await NotificationService.cancelNotification(reminder.id);

    setState(() {
      reminders.removeAt(index);
    });
    await saveReminders();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Reminder',
          style: TextStyle(
            color: isDark ? Colors.white : AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : AppColors.black,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => addOrEditReminder(),
        child: const Icon(
          Icons.add,
          size: 32,
          color: Colors.white,
        ),
      ),
      body: reminders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark
                          ? const Color(0xff1E1E1E)
                          : Colors.grey.shade100,
                    ),
                    child: Icon(
                      Icons.notifications_off_rounded,
                      size: 54,
                      color: isDark ? Colors.white38 : Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Belum Ada Reminder",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(18),
              itemCount: reminders.length,
              itemBuilder: (context, index) {
                final reminder = reminders[index];

                return Dismissible(
                  key: Key(reminder.id.toString()),
                  direction: DismissDirection.horizontal,
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.endToStart) {
                      addOrEditReminder(
                        existingReminder: reminder,
                        editIndex: index,
                      );
                      return false;
                    } else {
                      final bool? confirmed =
                          await showDeleteConfirmationDialog(context);
                      if (confirmed == true) {
                        deleteReminder(index);
                        return true;
                      }
                      return false;
                    }
                  },
                  background: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.delete, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "Hapus",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  secondaryBackground: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Edit",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.edit, color: Colors.white),
                      ],
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xff1E1E1E) : AppColors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(isDark ? 0.2 : 0.03),
                          blurRadius: 12,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 58,
                          height: 58,
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xff2A2A2A)
                                : AppColors.secondary,
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
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                reminder.time,
                                style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      isDark ? Colors.white54 : AppColors.grey,
                                ),
                              ),
                              const SizedBox(height: 2),
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

                                if (value) {
                                  final parts = reminder.time.split(':');
                                  final hour = int.parse(parts[0]);
                                  final minute = int.parse(parts[1]);

                                  await NotificationService
                                      .scheduleDailyNotification(
                                    id: reminder.id,
                                    title: "Waktunya ${reminder.title}!",
                                    body:
                                        "Yuk, segera tunaikan habit dan ibadahmu hari ini.",
                                    hour: hour,
                                    minute: minute,
                                  );
                                } else {
                                  await NotificationService.cancelNotification(
                                      reminder.id);
                                }

                                await saveReminders();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class ReminderModel {
  int id;
  String title;
  String time;
  bool isActive;
  String repeatType;
  List<int> selectedDays;

  ReminderModel({
    required this.id,
    required this.title,
    required this.time,
    required this.isActive,
    required this.repeatType,
    required this.selectedDays,
  });

  factory ReminderModel.fromJson(Map<String, dynamic> json) {
    return ReminderModel(
      id: json['id'] ?? DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: json['title'] ?? '',
      time: json['time'] ?? '',
      isActive: json['isActive'] ?? false,
      repeatType: json['repeatType'] ?? 'every_day',
      selectedDays: json['selectedDays'] != null
          ? List<int>.from(json['selectedDays'])
          : [1, 2, 3, 4, 5, 6, 7],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'time': time,
      'isActive': isActive,
      'repeatType': repeatType,
      'selectedDays': selectedDays,
    };
  }
}

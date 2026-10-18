import 'package:flutter/material.dart';
import 'package:muslim_journey/core/constants/colors.dart';
import 'package:muslim_journey/pages/target/models/target_model.dart';
import 'package:muslim_journey/providers/target_provider.dart';
import 'package:provider/provider.dart';

class AddTargetPage extends StatefulWidget {
  final TargetModel? target; // Opsional: Diisi jika mode Edit
  final int? targetIndex; // Opsional: Indeks target yang akan di-edit

  const AddTargetPage({
    super.key,
    this.target,
    this.targetIndex,
  });

  @override
  State<AddTargetPage> createState() => _AddTargetPageState();
}

class _AddTargetPageState extends State<AddTargetPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final targetCountController = TextEditingController();

  final List<String> categories = [
    'Sholat',
    'Quran',
    'Dzikir',
    'Puasa',
    'Sedekah',
  ];

  final List<String> frequencies = [
    'Harian',
    'Mingguan',
    'Bulanan',
  ];

  final List<String> weekDays = [
    'Sen',
    'Sel',
    'Rab',
    'Kam',
    'Jum',
    'Sab',
    'Min',
  ];

  List<String> selectedDays = [];

  final List<String> targetUnits = [
    'Tidak Ada',
    'Kali',
    'Rakaat',
    'Ayat',
    'Halaman',
    'Juz',
    'Hari',
  ];

  String selectedUnit = 'Tidak Ada';

  final List<IconData> icons = [
    Icons.mosque_rounded,
    Icons.menu_book_rounded,
    Icons.favorite_rounded,
    Icons.nightlight_round,
    Icons.volunteer_activism_rounded,
    Icons.star_rounded,
    Icons.person,
  ];

  String selectedCategory = 'Sholat';
  String selectedFrequency = 'Harian';
  IconData selectedIcon = Icons.mosque_rounded;
  bool reminderEnabled = false;

  TimeOfDay reminderTime = const TimeOfDay(
    hour: 4,
    minute: 30,
  );

  @override
  void initState() {
    super.initState();
    if (widget.target != null) {
      final t = widget.target!;
      titleController.text = t.title;
      descriptionController.text = t.subtitle;
      targetCountController.text = t.targetCount.toString();
      selectedCategory = t.category;
      selectedFrequency = t.frequency;
      selectedIcon = t.icon;
      selectedDays = List.from(t.activeDays);
      selectedUnit = t.unit;
      reminderEnabled = t.reminderEnabled;
      reminderTime = TimeOfDay(hour: t.reminderHour, minute: t.reminderMinute);
    }
  }

  Future<void> pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: reminderTime,
    );

    if (picked != null) {
      setState(() {
        reminderTime = picked;
      });
    }
  }

  void saveHabit() {
    if (titleController.text.isEmpty) return;

    if (selectedDays.isEmpty) {
      selectedDays = weekDays;
    }

    final updatedTarget = TargetModel(
      title: titleController.text,
      subtitle: descriptionController.text,
      icon: selectedIcon,
      category: selectedCategory,
      frequency: selectedFrequency,
      reminderEnabled: reminderEnabled,
      reminderHour: reminderTime.hour,
      reminderMinute: reminderTime.minute,
      targetCount: int.tryParse(targetCountController.text) ?? 1,
      activeDays: selectedDays,
      unit: selectedUnit,
    );

    final provider = context.read<TargetProvider>();

    if (widget.targetIndex != null) {
      provider.updateTarget(widget.targetIndex!, updatedTarget);
    } else {
      provider.addTarget(updatedTarget);
    }

    Navigator.pop(context);
  }

  // TOGGLE CATEGORY
  void openCategoryModal() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xff1E1E1E) : AppColors.white,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 52,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const SizedBox(width: 10),
                  Text(
                    'Pilih Kategori',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              GridView.builder(
                shrinkWrap: true,
                itemCount: categories.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 2.8,
                ),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final selected = selectedCategory == category;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category;
                      });
                      Navigator.pop(context);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      decoration: BoxDecoration(
                        color: selected
                            ? AppColors.primary
                            : (isDark
                                ? const Color(0xff2A2A2A)
                                : AppColors.secondary),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          category,
                          style: TextStyle(
                            color: selected
                                ? Colors.white
                                : (isDark ? Colors.white70 : AppColors.primary),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // ACTIVE DAYS
  void openDaysModal() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xff1E1E1E) : AppColors.white,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 52,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Icon(Icons.calendar_month_rounded,
                      color: AppColors.primary),
                  const SizedBox(width: 10),
                  Text(
                    'Hari Aktif',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              GridView.builder(
                shrinkWrap: true,
                itemCount: weekDays.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 2.2,
                ),
                itemBuilder: (context, index) {
                  final day = weekDays[index];
                  final selected = selectedDays.contains(day);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selectedDays.contains(day)) {
                          selectedDays.remove(day);
                        } else {
                          selectedDays.add(day);
                        }
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      decoration: BoxDecoration(
                        color: selected
                            ? AppColors.primary
                            : (isDark
                                ? const Color(0xff2A2A2A)
                                : AppColors.secondary),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Center(
                        child: Text(
                          day,
                          style: TextStyle(
                            color: selected
                                ? Colors.white
                                : (isDark ? Colors.white70 : AppColors.primary),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  // TOGGLE ICON HABIT
  void openIconModal() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xff1E1E1E) : AppColors.white,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 52,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  const SizedBox(width: 10),
                  Text(
                    'Pilih Icon Habit',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              GridView.builder(
                shrinkWrap: true,
                itemCount: icons.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                ),
                itemBuilder: (context, index) {
                  final icon = icons[index];
                  final selected = selectedIcon == icon;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIcon = icon;
                      });
                      Navigator.pop(context);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      decoration: BoxDecoration(
                        color: selected
                            ? AppColors.primary
                            : (isDark
                                ? const Color(0xff2A2A2A)
                                : AppColors.secondary),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Icon(
                        icon,
                        size: 30,
                        color: selected
                            ? Colors.white
                            : (isDark ? Colors.white70 : AppColors.primary),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // UNIT MODAL
  void openUnitModal() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xff1E1E1E) : AppColors.white,
            borderRadius: BorderRadius.circular(32),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 52,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Text(
                      'Pilih Satuan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ...targetUnits.map((e) {
                  final selected = selectedUnit == e;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedUnit = e;
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: selected
                            ? AppColors.primary
                            : (isDark
                                ? const Color(0xff2A2A2A)
                                : AppColors.background),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              e,
                              style: TextStyle(
                                color: selected
                                    ? Colors.white
                                    : (isDark ? Colors.white : AppColors.black),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (selected)
                            const Icon(
                              Icons.check_rounded,
                              color: Colors.white,
                            ),
                        ],
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : AppColors.primary,
            size: 24,
          ),
        ),
        centerTitle: true,
        title: Text(
          widget.targetIndex != null ? 'Edit Habit' : 'Tambah Habit',
          style: TextStyle(
            color: isDark ? Colors.white : AppColors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(18),
        child: SizedBox(
          height: 58,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: saveHabit,
            child: Text(
              widget.targetIndex != null ? 'Perbarui Habit' : 'Simpan Habit',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TITLE
            Text(
              'Nama Habit',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: titleController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              style: TextStyle(color: isDark ? Colors.white : Colors.black87),
              decoration: inputDecoration('Contoh: Sholat Tahajud', isDark),
            ),

            const SizedBox(height: 22),

            /// DESCRIPTION
            Text(
              'Deskripsi',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              style: TextStyle(color: isDark ? Colors.white : Colors.black87),
              decoration: inputDecoration('Tambahkan deskripsi habit', isDark),
            ),

            const SizedBox(height: 22),

            /// CATEGORY
            GestureDetector(
              onTap: openCategoryModal,
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xff1E1E1E) : AppColors.white,
                  borderRadius: BorderRadius.circular(22),
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
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        selectedCategory,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: isDark ? Colors.white54 : AppColors.grey,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 22),

            /// FREQUENCY
            Text(
              'Frekuensi',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: frequencies.map((e) {
                final selected = selectedFrequency == e;

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFrequency = e;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: selected
                            ? AppColors.primary
                            : (isDark
                                ? const Color(0xff1E1E1E)
                                : AppColors.white),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(isDark ? 0.2 : 0.03),
                            blurRadius: 12,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          e,
                          style: TextStyle(
                            color: selected
                                ? Colors.white
                                : (isDark ? Colors.white : AppColors.black),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 22),

            /// ACTIVE DAYS
            Text(
              'Hari Aktif',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
            const SizedBox(height: 14),
            GestureDetector(
              onTap: openDaysModal,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xff1E1E1E) : AppColors.white,
                  borderRadius: BorderRadius.circular(22),
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
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xff2A2A2A)
                            : AppColors.secondary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.calendar_month_rounded,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hari Aktif',
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            selectedDays.isEmpty
                                ? 'Pilih hari aktif'
                                : selectedDays.toSet().join(', '),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: isDark ? Colors.white54 : AppColors.grey,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 22),

            /// ICON
            GestureDetector(
              onTap: openIconModal,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xff1E1E1E) : AppColors.white,
                  borderRadius: BorderRadius.circular(22),
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
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xff2A2A2A)
                            : AppColors.secondary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        selectedIcon,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Icon Habit',
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Pilih icon habit',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: isDark ? Colors.white54 : AppColors.grey,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 22),

            /// TARGET COUNT
            Text(
              'Target Ibadah',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: targetCountController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(
                        color: isDark ? Colors.white : Colors.black87),
                    decoration: inputDecoration('Jumlah', isDark),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: GestureDetector(
                    onTap: openUnitModal,
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color:
                            isDark ? const Color(0xff1E1E1E) : AppColors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(isDark ? 0.2 : 0.03),
                            blurRadius: 12,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              selectedUnit,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: isDark ? Colors.white54 : AppColors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            /// REMINDER
            Container(
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
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.notifications_active_rounded,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Aktifkan Reminder',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                      Switch(
                        value: reminderEnabled,
                        onChanged: (value) {
                          setState(() {
                            reminderEnabled = value;
                          });
                        },
                      ),
                    ],
                  ),
                  if (reminderEnabled)
                    Column(
                      children: [
                        const SizedBox(height: 18),
                        GestureDetector(
                          onTap: pickTime,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xff2A2A2A)
                                  : AppColors.background,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.access_time_rounded,
                                  color:
                                      isDark ? Colors.white70 : Colors.black54,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  reminderTime.format(context),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        isDark ? Colors.white : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),

            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String hint, bool isDark) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.grey),
      filled: true,
      fillColor: isDark ? const Color(0xff1E1E1E) : AppColors.white,
      contentPadding: const EdgeInsets.all(18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: BorderSide.none,
      ),
    );
  }
}

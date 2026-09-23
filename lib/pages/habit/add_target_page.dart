import 'package:flutter/material.dart';

import 'package:muslim_journey/core/constants/colors.dart';
import 'package:muslim_journey/pages/target/data/target_data.dart';
import 'package:muslim_journey/pages/target/models/target_model.dart';

class AddTargetPage extends StatefulWidget {
  const AddTargetPage({super.key});

  @override
  State<AddTargetPage> createState() => _AddTargetPageState();
}

class _AddTargetPageState extends State<AddTargetPage> {
  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

  final targetController = TextEditingController();

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

  //
  final targetCountController = TextEditingController();

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
    if (titleController.text.isEmpty) {
      return;
    }

    // ALL DAYS
    if (selectedDays.isEmpty) {
      selectedDays = weekDays;
    }

    targetList.add(
      TargetModel(
        title: titleController.text,
        subtitle: descriptionController.text,
        icon: selectedIcon,
        category: selectedCategory,
        frequency: selectedFrequency,
        reminderEnabled: reminderEnabled,
        reminderHour: reminderTime.hour,
        reminderMinute: reminderTime.minute,
        targetCount: int.tryParse(
              targetCountController.text,
            ) ??
            1,
        activeDays: selectedDays,
        currentCount: 0,
        unit: selectedUnit,
      ),
    );

    Navigator.pop(context);
  }

  // TOGGLE CATEGORY
  void openCategoryModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// HANDLE
              Container(
                width: 52,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              const SizedBox(height: 24),

              /// TITLE
              const Row(
                children: [
                  SizedBox(width: 10),
                  Text(
                    'Pilih Kategori',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// CATEGORY LIST
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
                itemBuilder: (
                  context,
                  index,
                ) {
                  final category = categories[index];

                  final selected = selectedCategory == category;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category;
                      });

                      Navigator.pop(
                        context,
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 250,
                      ),
                      decoration: BoxDecoration(
                        color:
                            selected ? AppColors.primary : AppColors.secondary,
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          category,
                          style: TextStyle(
                            color: selected ? Colors.white : AppColors.primary,
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
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// HANDLE
              Container(
                width: 52,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// TITLE
              const Row(
                children: [
                  Icon(
                    Icons.calendar_month_rounded,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Hari Aktif',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// DAYS
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
                itemBuilder: (
                  context,
                  index,
                ) {
                  final day = weekDays[index];

                  final selected = selectedDays.contains(
                    day,
                  );

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
                      duration: const Duration(
                        milliseconds: 250,
                      ),
                      decoration: BoxDecoration(
                        color:
                            selected ? AppColors.primary : AppColors.secondary,
                        borderRadius: BorderRadius.circular(
                          18,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          day,
                          style: TextStyle(
                            color: selected ? Colors.white : AppColors.primary,
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
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// HANDLE
              Container(
                width: 52,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              const SizedBox(height: 24),

              /// TITLE
              const Row(
                children: [
                  SizedBox(width: 10),
                  Text(
                    'Pilih Icon Habit',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// GRID ICON
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
                      duration: const Duration(
                        milliseconds: 250,
                      ),
                      decoration: BoxDecoration(
                        color:
                            selected ? AppColors.primary : AppColors.secondary,
                        borderRadius: BorderRadius.circular(
                          22,
                        ),
                      ),
                      child: Icon(
                        icon,
                        size: 30,
                        color: selected ? Colors.white : AppColors.primary,
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

  // SECTION TARGET
  // SECTION TARGET
  void openUnitModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled:
          true, // Membantu agar modal menyesuaikan tinggi konten
      builder: (_) {
        return Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(32),
          ),
          child: SingleChildScrollView(
            // Tambahkan ini agar konten bisa di-scroll
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
                const Row(
                  children: [
                    SizedBox(width: 10),
                    Text(
                      'Pilih Satuan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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
                        color:
                            selected ? AppColors.primary : AppColors.background,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              e,
                              style: TextStyle(
                                color:
                                    selected ? Colors.white : AppColors.black,
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
                }).toList(),
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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primary,
            size: 24,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Tambah Habit',
          style: TextStyle(
            color: AppColors.black,
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
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
            ),
            onPressed: saveHabit,
            child: const Text(
              'Simpan Habit',
              style: TextStyle(
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
            const Text(
              'Nama Habit',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: titleController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: inputDecoration(
                'Contoh: Sholat Tahajud',
              ),
            ),

            const SizedBox(height: 22),

            /// DESCRIPTION
            const Text(
              'Deskripsi',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: descriptionController,
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              decoration: inputDecoration(
                'Tambahkan deskripsi habit',
              ),
            ),

            const SizedBox(height: 22),

            /// CATEGORY
            GestureDetector(
              onTap: openCategoryModal,
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        selectedCategory,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down_rounded),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 22),

            /// FREQUENCY
            const Text(
              'Frekuensi',
              style: TextStyle(
                fontWeight: FontWeight.bold,
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
                      duration: const Duration(
                        milliseconds: 250,
                      ),
                      margin: const EdgeInsets.only(
                        right: 10,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: selected ? AppColors.primary : AppColors.white,
                        borderRadius: BorderRadius.circular(
                          18,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          e,
                          style: TextStyle(
                            color: selected ? Colors.white : AppColors.black,
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
            const Text(
              'Hari Aktif',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: GestureDetector(
                onTap: openDaysModal,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
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
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                      ),
                    ],
                  ),
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
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        selectedIcon,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Icon Habit',
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Pilih icon habit',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 22),

            /// TARGET COUNT
            const Text(
              'Target Ibadah',
              style: TextStyle(
                fontWeight: FontWeight.bold,
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
                    decoration: inputDecoration(
                      'Jumlah',
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: GestureDetector(
                    onTap: openUnitModal,
                    child: Container(
                      padding: const EdgeInsets.all(
                        18,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(
                          22,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              selectedUnit,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down_rounded,
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
                color: AppColors.white,
                borderRadius: BorderRadius.circular(
                  24,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.notifications_active_rounded,
                        color: AppColors.primary,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      const Expanded(
                        child: Text(
                          'Aktifkan Reminder',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
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
                        const SizedBox(
                          height: 18,
                        ),
                        GestureDetector(
                          onTap: pickTime,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(
                              16,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(
                                18,
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.access_time_rounded,
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  reminderTime.format(
                                    context,
                                  ),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
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

  InputDecoration inputDecoration(
    String hint,
  ) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: AppColors.white,
      contentPadding: const EdgeInsets.all(18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: BorderSide.none,
      ),
    );
  }
}

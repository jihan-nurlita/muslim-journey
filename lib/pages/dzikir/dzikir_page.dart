import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:muslim_journey/core/constants/colors.dart';
import 'package:muslim_journey/pages/dzikir/add_dzikir_page.dart';
import 'package:muslim_journey/pages/dzikir/dzikir_detail_page.dart';
import 'package:muslim_journey/pages/dzikir/models/dzikir_model.dart';
import 'package:muslim_journey/pages/navigation/custom_bottom_navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DzikirPage extends StatefulWidget {
  const DzikirPage({super.key});

  @override
  State<DzikirPage> createState() => _DzikirPageState();
}

class _DzikirPageState extends State<DzikirPage> {
  List<DzikirModel> dzikirList = [];

  Future<void> loadDzikir() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('dzikir_data');

    if (data != null) {
      final decoded = jsonDecode(data) as List;
      dzikirList = decoded.map((e) => DzikirModel.fromJson(e)).toList();
    } else {
      dzikirList = defaultDzikir;
    }

    setState(() {});
  }

  Future<void> saveDzikir() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(
      dzikirList.map((e) => e.toJson()).toList(),
    );
    await prefs.setString('dzikir_data', encoded);
  }

  @override
  void initState() {
    super.initState();
    loadDzikir();
  }

  final defaultDzikir = [
    DzikirModel(
      title: 'Istigfar',
      arab: 'أَسْتَغْفِرُ اللهَ الْعَظِيْمَ',
      latin: 'Astaghfirullahal adzim',
      meaning: 'Aku memohon ampun kepada Allah Yang Maha Agung',
      target: 100,
      icon: Icons.auto_awesome_rounded,
    ),
    DzikirModel(
      title: 'Sholawat',
      arab: 'اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ',
      latin: 'Allahumma shalli ala Muhammad',
      meaning: 'Ya Allah limpahkan sholawat kepada Nabi Muhammad',
      target: 1000,
      icon: Icons.auto_awesome_rounded,
    ),
    DzikirModel(
      title: 'Sholawat ',
      arab: 'صَلَّى اللهُ عَلَى مُحَمَّد',
      latin: 'Shalallaahu ala Muhammad',
      meaning: 'Ya Allah limpahkan sholawat kepada Nabi Muhammad',
      target: 1000,
      icon: Icons.auto_awesome_rounded,
    ),
    DzikirModel(
      title: 'Tasbih',
      arab: 'سُبْحَانَ اللهِ',
      latin: 'Subhanallah',
      meaning: 'Maha Suci Allah',
      target: 33,
      icon: Icons.auto_awesome_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Cek apakah sedang mode gelap
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // 🔥 Mengecek secara otomatis apakah halaman ini bisa di-pop (artinya dibuka dari kotak Home, bukan dari Navbar)
    final bool canPop = Navigator.canPop(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddDzikirPage(),
            ),
          );

          if (result != null) {
            dzikirList.add(result);
            await saveDzikir();
            setState(() {});
          }
        },
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 32,
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: const CustomBottomNavbar(currentIndex: 1),
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        // 🔥 Otomatis true jika dari Home (ada tombol panah), otomatis false jika dari Navbar bawah (bersih tanpa tombol panah)
        automaticallyImplyLeading: canPop,
        centerTitle: true,
        title: Text(
          'Dzikir Harian',
          style: TextStyle(
            color: isDark ? Colors.white : AppColors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(
          color: isDark ? Colors.white : AppColors.primary,
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(18),
        itemCount: dzikirList.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final dzikir = dzikirList[index];

          return Dismissible(
            key: ValueKey(dzikir.title + index.toString()),
            direction: DismissDirection.horizontal,
            confirmDismiss: (direction) async {
              // 🔥 SWIPE KANAN (Start to End) -> HAPUS (Warna Merah + Dialog)
              if (direction == DismissDirection.startToEnd) {
                return await showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    backgroundColor:
                        isDark ? const Color(0xff1E1E1E) : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: const Text(
                      "Hapus Dzikir?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: const Text(
                      "Apakah kamu yakin ingin menghapus?",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text(
                          "Batal",
                          style: TextStyle(
                            color: AppColors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text(
                          "Hapus",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              // 🔥 SWIPE KIRI (End to Start) -> EDIT (Warna Biru)
              if (direction == DismissDirection.endToStart) {
                final currentIndex = index;
                final currentDzikir = dzikirList[index];

                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddDzikirPage(editDzikir: currentDzikir),
                  ),
                );

                if (result != null) {
                  dzikirList[currentIndex] = result;
                  await saveDzikir();
                  setState(() {});
                }

                return false; // Jangan hapus item dari list
              }

              return false;
            },
            onDismissed: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                dzikirList.removeAt(index);
                await saveDzikir();
                setState(() {});
              }
            },
            // Background Swipe Kanan (Hapus - Warna Merah)
            background: Container(
              padding: const EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 30,
              ),
            ),
            // Background Swipe Kiri (Edit - Warna Biru)
            secondaryBackground: Container(
              padding: const EdgeInsets.only(right: 20),
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.edit,
                color: Colors.white,
                size: 30,
              ),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DzikirDetailPage(dzikir: dzikir),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xff1E1E1E) : AppColors.white,
                  borderRadius: BorderRadius.circular(30),
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
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xff2A2A2A)
                            : AppColors.secondary,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Icon(
                        dzikir.icon,
                        color: AppColors.primary,
                        size: 34,
                      ),
                    ),
                    const SizedBox(width: 19),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dzikir.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                            maxLines: 1,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            dzikir.latin,
                            style: TextStyle(
                              color: isDark ? Colors.white54 : Colors.black54,
                            ),
                            maxLines: 1,
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color(0xff2A2A2A)
                                  : AppColors.secondary,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(
                              'Target ${dzikir.target}',
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.primary,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

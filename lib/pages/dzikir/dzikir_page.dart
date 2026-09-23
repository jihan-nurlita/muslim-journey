import 'dart:convert';
import 'package:muslim_journey/core/constants/colors.dart';
import 'package:muslim_journey/pages/dzikir/add_dzikir_page.dart';
import 'package:muslim_journey/pages/dzikir/dzikir_detail_page.dart';
import 'package:muslim_journey/pages/dzikir/models/dzikir_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

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
      icon: Icons.favorite_rounded,
    ),
    DzikirModel(
      title: 'Sholawat ',
      arab: 'صَلَّى اللهُ عَلَى مُحَمَّد',
      latin: 'Shalallaahu ala Muhammad',
      meaning: 'Ya Allah limpahkan sholawat kepada Nabi Muhammad',
      target: 1000,
      icon: Icons.favorite_rounded,
    ),
    DzikirModel(
      title: 'Tasbih',
      arab: 'سُبْحَانَ اللهِ',
      latin: 'Subhanallah',
      meaning: 'Maha Suci Allah',
      target: 33,
      icon: Icons.brightness_5_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
        child: const Icon(Icons.add_rounded, color: Colors.white),
      ),
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
          'Dzikir Harian',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(18),
        itemCount: dzikirList.length,
        itemBuilder: (context, index) {
          final dzikir = dzikirList[index];

          return Dismissible(
            key: ValueKey(dzikir.title + index.toString()),
            direction: DismissDirection.horizontal,
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                // ⬅️ SWIPE KIRI = DELETE
                return await showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Hapus Dzikir?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text("Batal"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text("Hapus"),
                      ),
                    ],
                  ),
                );
              }

              if (direction == DismissDirection.startToEnd) {
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

                return false;
              }

              return false;
            },
            onDismissed: (direction) async {
              if (direction == DismissDirection.endToStart) {
                dzikirList.removeAt(index);
                await saveDzikir();
                setState(() {});
              }
            },
            background: Container(
              margin: const EdgeInsets.only(bottom: 18),
              padding: const EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
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
            secondaryBackground: Container(
              margin: const EdgeInsets.only(bottom: 18),
              padding: const EdgeInsets.only(right: 20),
              alignment: Alignment.centerRight,
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
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Icon(
                        dzikir.icon,
                        color: AppColors.primary,
                        size: 34,
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dzikir.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            dzikir.latin,
                            style: const TextStyle(color: Colors.black54),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.secondary,
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

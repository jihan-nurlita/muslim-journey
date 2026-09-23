import 'package:flutter/material.dart';
import 'package:muslim_journey/core/constants/colors.dart';
import 'package:muslim_journey/pages/sholat/detail_sholat_page.dart';
import 'package:muslim_journey/pages/sholat/sholat_data.dart';

class SholatPage extends StatefulWidget {
  const SholatPage({super.key});

  @override
  State<SholatPage> createState() => _SholatPageState();
}

class _SholatPageState extends State<SholatPage> {
  List<DoaModel> filteredDoa = [];

  String selectedCategory = "Semua";

  final List<String> categories = [
    "Semua",
    "Wudhu",
    "Sholat",
    "Doa-Doa",
  ];

  @override
  void initState() {
    super.initState();
    filteredDoa = doaList;
  }

  // =====================================================
  // SEARCH
  // =====================================================

  void searchDoa(String keyword) {
    final result = doaList.where((doa) {
      final matchKeyword =
          doa.judul.toLowerCase().contains(keyword.toLowerCase());

      final matchCategory = selectedCategory == "Semua"
          ? true
          : doa.kategori.contains(selectedCategory);

      return matchKeyword && matchCategory;
    }).toList();

    setState(() {
      filteredDoa = result;
    });
  }

  // =====================================================
  // FILTER CATEGORY
  // =====================================================

  void filterByCategory(String category) {
    setState(() {
      selectedCategory = category;

      if (category == "Semua") {
        filteredDoa = doaList;
      } else {
        filteredDoa =
            doaList.where((e) => e.kategori.contains(category)).toList();
      }
    });
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      // ===================================================
      // APP BAR
      // ===================================================

      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
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
        title: const Text(
          "Panduan Ibadah",
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),

      // ===================================================
      // BODY
      // ===================================================

      body: Column(
        children: [
          // =================================================
          // SEARCH & CATEGORY
          // =================================================

          Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              top: 20,
            ),
            child: Column(
              children: [
                // ===========================================
                // SEARCH
                // ===========================================

                TextField(
                  onChanged: searchDoa,
                  decoration: InputDecoration(
                    hintText: "Cari panduan & doa ibadah...",
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.primary,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 14,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // ===========================================
                // CATEGORY
                // ===========================================

                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final cat = categories[index];
                      final isActive = selectedCategory == cat;

                      return GestureDetector(
                        onTap: () => filterByCategory(cat),
                        child: Container(
                          margin: const EdgeInsets.only(
                            right: 10,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isActive
                                ? AppColors.primary
                                : AppColors.secondary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            cat,
                            style: TextStyle(
                              color:
                                  isActive ? Colors.white : AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // =================================================
          // LIST PANDUAN
          // =================================================

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: 24,
              ),
              itemCount: filteredDoa.length,
              itemBuilder: (context, index) {
                final doa = filteredDoa[index];

                return SholatTile(
                  number: "${index + 1}",
                  title: doa.judul,
                  doa: doa,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// SHOLAT TILE
// =====================================================

class SholatTile extends StatelessWidget {
  final String number;
  final String title;
  final DoaModel doa;

  const SholatTile({
    super.key,
    required this.number,
    required this.title,
    required this.doa,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailSholatPage(
              doa: doa,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 16,
        ),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            // =============================================
            // NOMOR
            // =============================================

            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  number,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 16),

            // =============================================
            // JUDUL
            // =============================================

            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // =============================================
            // ARROW
            // =============================================

            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}

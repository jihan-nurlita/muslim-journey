import 'package:flutter/material.dart';
import 'package:muslim_journey/core/constants/colors.dart';
import 'package:muslim_journey/pages/dzikir/models/dzikir_model.dart';

class AddDzikirPage extends StatefulWidget {
  final DzikirModel? editDzikir;

  const AddDzikirPage({super.key, this.editDzikir});

  @override
  State<AddDzikirPage> createState() => _AddDzikirPageState();
}

class _AddDzikirPageState extends State<AddDzikirPage> {
  final titleController = TextEditingController();
  final arabController = TextEditingController();
  final latinController = TextEditingController();
  final meaningController = TextEditingController();
  final targetController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    // 🔥 AUTO FILL JIKA EDIT
    if (widget.editDzikir != null) {
      final dzikir = widget.editDzikir!;
      titleController.text = dzikir.title;
      arabController.text = dzikir.arab;
      latinController.text = dzikir.latin;
      meaningController.text = dzikir.meaning;
      targetController.text = dzikir.target.toString();
    }
  }

  void saveDzikir() {
    final target = int.tryParse(targetController.text);

    if (titleController.text.trim().isEmpty || target == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Nama & target wajib diisi")),
      );
      return;
    }

    final dzikir = DzikirModel(
      title: titleController.text.trim(),
      arab: arabController.text.trim(),
      latin: latinController.text.trim(),
      meaning: meaningController.text.trim(),
      target: target,
      icon: Icons.auto_awesome_rounded,
      isCustom: true,
    );

    Navigator.pop(context, dzikir);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
        title: Text(
          'Tambah Dzikir',
          style: TextStyle(
            color: isDark ? Colors.white : AppColors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _input(
              context: context,
              title: 'Nama Dzikir',
              controller: titleController,
              hint: 'Sholawat Jibril',
            ),
            const SizedBox(height: 18),

            /// INPUT TULISAN ARAB (Diatur Rata Kanan / RTL)
            _input(
              context: context,
              title: 'Tulisan Arab',
              controller: arabController,
              hint: 'اللهم صل على محمد',
              maxLines: 3,
              isArab: true,
            ),
            const SizedBox(height: 18),
            _input(
              context: context,
              title: 'Latin',
              controller: latinController,
              hint: 'Allahumma shalli ala Muhammad',
            ),
            const SizedBox(height: 18),
            _input(
              context: context,
              title: 'Arti',
              controller: meaningController,
              hint: 'Ya Allah limpahkan sholawat...',
              maxLines: 3,
            ),
            const SizedBox(height: 18),
            _input(
              context: context,
              title: 'Target Dzikir',
              controller: targetController,
              hint: '10000',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: isLoading ? null : saveDzikir,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Simpan Dzikir',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input({
    required BuildContext context,
    required String title,
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    bool isArab = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: isDark ? Colors.white : AppColors.black,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          autofocus: false,
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          textAlign: isArab ? TextAlign.right : TextAlign.left,
          textDirection: isArab ? TextDirection.rtl : TextDirection.ltr,
          style: TextStyle(
            fontSize: isArab ? 20 : 16,
            color: isDark ? Colors.white : AppColors.black,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: isDark ? Colors.white54 : Colors.grey,
              fontSize: isArab ? 18 : 14,
            ),
            filled: true,
            fillColor: isDark ? const Color(0xff1E1E1E) : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

import 'dart:convert'; // <-- TAMBAHKAN INI DI BAGIAN ATAS
import 'package:flutter/material.dart';
import 'package:muslim_journey/core/constants/colors.dart';
import 'package:muslim_journey/pages/login/login_page.dart';
import 'package:muslim_journey/pages/navigation/custom_bottom_navbar.dart';
import 'package:muslim_journey/pages/notification/notification_page.dart';
import 'package:muslim_journey/pages/profile/edit_profile_page.dart';
import 'package:muslim_journey/providers/theme_provider.dart';
import 'package:muslim_journey/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = 'Memuat...';
  String userEmail = 'Memuat...';
  String? userImage;

  int userLevel = 1;
  int totalTarget = 0;
  int userBadge = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Mengambil data nama, email, dan foto secara aman
  Future<void> _loadUserData() async {
    try {
      final name = await AuthService.getUserName();
      final email = await AuthService.getUserEmail();
      final image = await AuthService.getUserImage();

      final prefs = await SharedPreferences.getInstance();

      // Ambil data string JSON dari SharedPreferences
      final String? savedListString = prefs.getString('custom_target_list');
      int targetCount = 0;
      if (savedListString != null && savedListString.isNotEmpty) {
        final List<dynamic> decodedList = jsonDecode(savedListString);
        targetCount = decodedList.length; // Hitung jumlah total target yang ada
      }

      final int streakCount = prefs.getInt('streak') ?? 0;

      if (mounted) {
        setState(() {
          userName = name;
          userEmail = email;
          userImage = image;
          totalTarget = targetCount; // Masukkan jumlah target yang benar
          userLevel = (streakCount ~/ 5) + 1;
          userBadge = streakCount >= 30 ? 3 : (streakCount >= 10 ? 2 : 1);
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          userName = 'Pengguna';
          userEmail = '';
        });
      }
    }
  }

  // 1. Pop-up Reset Progress Habit Saja
  void _showResetProgressDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDark ? const Color(0xff1E1E1E) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Reset Progress Habit',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          content: const Text(
            'Apakah kamu yakin ingin mereset seluruh target habit, riwayat, dan streak? Akun kamu akan tetap masuk.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Batal',
                style: TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();

                final prefs = await SharedPreferences.getInstance();

                // Hapus semua kemungkinan key data target/streak yang dipakai aplikasi
                await prefs.remove('custom_target_list');
                await prefs.remove('target_list'); // Tambahan jaga-jaga
                await prefs.remove('daily_habit_progress');
                await prefs.remove('streak');

                // Panggil ulang _loadUserData() agar tampilan langsung berubah jadi 0!
                await _loadUserData();

                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Progress habit dan streak berhasil direset.'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Reset Progress',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  // 2. Pop-up Factory Reset Total
  void _showFactoryResetDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDark ? const Color(0xff1E1E1E) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Factory Reset',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          content: const Text(
            'Apakah kamu yakin ingin mereset seluruh data aplikasi? Semua akun, target habit, dan riwayat akan dihapus total.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Batal',
                style: TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();

                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();

                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Seluruh data aplikasi berhasil direset total.'),
                    ),
                  );
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                    (route) => false,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Reset Total',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  // 3. Pop-up Peringatan Keluar (Logout)
  void _showLogoutDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isDark ? const Color(0xff1E1E1E) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Keluar Aplikasi',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Apakah kamu yakin ingin keluar dari akun Habit Muslim?',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Batal',
                style: TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await AuthService.logout();
                if (mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                    (route) => false,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Keluar',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool hasImage = userImage != null && userImage!.isNotEmpty;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: const CustomBottomNavbar(currentIndex: 4),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              /// HEADER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff4A9B78),
                      Color(0xff2E7D5A),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.secondary,
                        border: Border.all(color: Colors.white, width: 4),
                        image: hasImage
                            ? DecorationImage(
                                image: NetworkImage(userImage!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: !hasImage
                          ? const Icon(
                              Icons.person_rounded,
                              size: 65,
                              color: Color(0xff2E7D5A),
                            )
                          : null,
                    ),
                    const SizedBox(height: 18),
                    Text(
                      userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userEmail,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _statItem(title: 'Level', value: userLevel.toString()),
                        _statItem(
                            title: 'Target', value: totalTarget.toString()),
                        _statItem(title: 'Badge', value: userBadge.toString()),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// MENU
              _menuTile(
                context: context,
                icon: Icons.person_outline_rounded,
                title: 'Edit Profile',
                subtitle: 'Ubah data profile',
                onTap: () async {
                  final bool? isUpdated = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EditProfilePage()),
                  );
                  if (isUpdated == true) {
                    _loadUserData();
                  }
                },
              ),

              const SizedBox(height: 14),

              _menuTile(
                context: context,
                icon: Icons.notifications_none_rounded,
                title: 'Notifikasi',
                subtitle: 'Atur pengingat ibadah',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationPage(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 14),

              _menuSwitchTile(
                context: context,
                icon: Icons.dark_mode_outlined,
                title: 'Tema Aplikasi',
                subtitle: isDark ? 'Mode Gelap Aktif' : 'Mode Terang Aktif',
                value: isDark,
                onChanged: (val) {
                  themeProvider.toggleTheme(val);
                },
              ),

              const SizedBox(height: 14),

              _menuTile(
                context: context,
                icon: Icons.lock_outline_rounded,
                title: 'Privasi',
                subtitle: 'Keamanan akun aplikasi',
                onTap: () {},
              ),

              const SizedBox(height: 14),

              _menuTile(
                context: context,
                icon: Icons.info_outline_rounded,
                title: 'Tentang Aplikasi',
                subtitle: 'Informasi aplikasi',
                onTap: () {},
              ),

              const SizedBox(height: 14),

              _menuTile(
                context: context,
                icon: Icons.refresh_rounded,
                title: 'Reset Progress Habit',
                subtitle: 'Hapus data target & streak saja',
                iconColor: AppColors.primary,
                onTap: () => _showResetProgressDialog(context),
              ),

              const SizedBox(height: 14),

              _menuTile(
                context: context,
                icon: Icons.lock_reset,
                title: 'Factory Reset',
                subtitle: 'Hapus seluruh data & akun aplikasi',
                iconColor: AppColors.primary,
                onTap: () => _showFactoryResetDialog(context),
              ),

              const SizedBox(height: 14),

              _menuTile(
                context: context,
                icon: Icons.logout_rounded,
                title: 'Keluar',
                subtitle: 'Logout dari aplikasi',
                iconColor: AppColors.primary,
                onTap: () => _showLogoutDialog(context),
              ),

              const SizedBox(height: 24),

              /// QUOTE
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff4A9B78),
                      Color(0xff2E7D5A),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Motivasi Hari Ini',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      '"Allah tidak membebani seseorang melainkan sesuai kesanggupannya."',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        height: 1.6,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'QS. Al-Baqarah : 286',
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 0),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _statItem({
  required String title,
  required String value,
}) {
  return Column(
    children: [
      Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        title,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 13,
        ),
      ),
    ],
  );
}

Widget _menuTile({
  required BuildContext context,
  required IconData icon,
  required String title,
  required String subtitle,
  required VoidCallback onTap,
  Color iconColor = AppColors.primary,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return InkWell(
    borderRadius: BorderRadius.circular(24),
    onTap: onTap,
    child: Container(
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
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xff2A2A2A) : AppColors.secondary,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              icon,
              color: iconColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: isDark ? Colors.white54 : AppColors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: isDark ? Colors.white54 : AppColors.grey,
          ),
        ],
      ),
    ),
  );
}

Widget _menuSwitchTile({
  required BuildContext context,
  required IconData icon,
  required String title,
  required String subtitle,
  required bool value,
  required ValueChanged<bool> onChanged,
  Color iconColor = AppColors.primary,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
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
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xff2A2A2A) : AppColors.secondary,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: isDark ? Colors.white54 : AppColors.grey,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primary,
        ),
      ],
    ),
  );
}

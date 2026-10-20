import 'package:flutter/material.dart';
import 'package:muslim_journey/pages/home/home_page.dart';
import 'package:muslim_journey/pages/login/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final prefs = await SharedPreferences.getInstance();

    String savedEmail =
        prefs.getString('user_email') ?? _emailController.text.trim();
    String savedName =
        prefs.getString('user_name') ?? _emailController.text.split('@')[0];

    await prefs.setBool('is_logged_in', true);
    await prefs.setString('user_email', savedEmail);
    await prefs.setString('user_name', savedName);

    setState(() => _isLoading = false);

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xff2E7D32);
    // Cek apakah mode gelap sedang aktif
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Header Ikon Masjid Lingkaran Elegan
                          Center(
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? primary.withOpacity(0.2)
                                    : primary.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.menu_book_rounded,
                                size: 55,
                                color: primary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Muslim Journey',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: primary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Masuk untuk melanjutkan perjalanan ibadahmu',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isDark ? Colors.white54 : Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Input Email
                          TextFormField(
                            autofocus: true,
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) =>
                                val == null || !val.contains('@')
                                    ? 'Email tidak valid'
                                    : null,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: const Icon(Icons.email_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Input Password
                          TextFormField(
                            autofocus: true,
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            validator: (val) => val == null || val.length < 6
                                ? 'Password minimal 6 karakter'
                                : null,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock_outlined),
                              suffixIcon: IconButton(
                                icon: Icon(_obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined),
                                onPressed: () => setState(
                                    () => _obscurePassword = !_obscurePassword),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Tombol Masuk
                          ElevatedButton(
                            onPressed: _isLoading ? null : _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : const Text(
                                    'Masuk',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                          const SizedBox(height: 20),

                          // Navigasi Registrasi
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Belum punya akun? ',
                                style: TextStyle(
                                  color: isDark ? Colors.white54 : Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const RegisterPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Daftar Sekarang',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primary,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

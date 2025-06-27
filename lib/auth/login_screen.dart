import 'package:duolingo/stack/main_tab_navigation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _secureStorage = FlutterSecureStorage();

  bool _obscurePassword = true;

  void handleLogin() async {
    if (_formKey.currentState!.validate()) {
      // ⚠️ Thay thế đoạn này bằng API thật nếu có
      // Giả lập token trả về từ API backend
      const fakeToken = "abc123xyz.token";

      // ✅ Lưu token an toàn
      await _secureStorage.write(key: 'access_token', value: fakeToken);

      Fluttertoast.showToast(msg: 'Đăng nhập thành công');

      // Chuyển trang chính
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainTabNavigation()),
      );
    }
  }

  void handleForgotPassword() {
    Fluttertoast.showToast(msg: 'Đi tới quên mật khẩu');
    Navigator.pushNamed(context, '/forgot-password');
  }

  void handleRegister() {
    Fluttertoast.showToast(msg: 'Đi tới đăng ký');
    Navigator.pushNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(), // Ẩn bàn phím
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        "×",
                        style: TextStyle(fontSize: 28, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      "https://media.giphy.com/media/MBP7KcK9d3lyqNWRaF/giphy.gif",
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.width * 0.4,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Đăng nhập tài khoản",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF58CC02),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  _buildTextField(
                    controller: _emailController,
                    label: 'Địa chỉ email',
                    hint: 'Nhập địa chỉ email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập email';
                      }
                      final emailRegex = RegExp(
                        r"^[a-zA-Z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$",
                      );
                      if (!emailRegex.hasMatch(value)) {
                        return 'Email không hợp lệ';
                      }
                      return null;
                    },
                  ),
                  _buildTextField(
                    controller: _passwordController,
                    label: 'Mật khẩu',
                    hint: 'Nhập mật khẩu',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.length < 8) {
                        return 'Mật khẩu phải từ 8 ký tự';
                      }
                      if (!value.contains(RegExp(r'[A-Z]'))) {
                        return 'Mật khẩu phải có ít nhất một chữ hoa';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: handleForgotPassword,
                      child: const Text(
                        'Bạn không nhớ mật khẩu? nhấn vào đây để khôi phục',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF58CC02),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 60,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Đăng Nhập',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: handleRegister,
                    child: const Text(
                      "Bạn chưa có tài khoản? Đăng ký tại đây",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          obscureText: obscureText ? _obscurePassword : false,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
            ),
            suffixIcon: obscureText
                ? IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  )
                : null,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

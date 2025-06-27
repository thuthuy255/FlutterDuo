// import 'package:duolingo/home/screen/home_screen.dart';
import 'package:duolingo/auth/services/auth.api.dart';
import 'package:duolingo/sharedpreferences/SharedPreferences.dart';
import 'package:duolingo/stack/main_tab_navigation.dart';
import 'package:duolingo/until/formatDecode.dart';
import 'package:duolingo/until/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;
  void handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text;
      // In ra kiểm tra (hoặc truyền đi API)
      final body = {'email': email, 'password': password};
      setState(() => isLoading = true); // Bật loading
      AuthService.login(body)
          .then((res) async {
            setState(() => isLoading = false);

            if (res['success'] == true) {
              final token = res['data']['token'];
              await saveTokenAndUserInfo(token); // ✅ Dùng hàm đã tách

              ToastUtil.show(res['message'], type: ToastType.success);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const MainTabNavigation()),
              );
            } else {
              ToastUtil.show(res['message'], type: ToastType.warning);
            }
          })
          .catchError((e) {
            setState(() => isLoading = false);
            print("❌ Lỗi đăng nhập: $e");
            ToastUtil.show('Có lỗi xảy ra khi login', type: ToastType.error);
          });
    }
  }

  void handleForgotPassword() {
    Navigator.pushNamed(context, '/forgot-password');
  }

  void handleRegister() {
    Navigator.pushNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(), // Ẩn bàn phím
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SafeArea(
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
                          if (!value.contains('@')) {
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
                          if (value == null || value.length < 6) {
                            return 'Mật khẩu tối thiểu 6 ký tự';
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
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.3),
                child: const Center(
                  child: CircularProgressIndicator(color: Color(0xFF58CC02)),
                ),
              ),
          ],
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
          obscureText: obscureText,
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
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

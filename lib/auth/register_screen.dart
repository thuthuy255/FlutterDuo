import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();

  void handleRegister() {
    if (_formKey.currentState!.validate()) {
      // Gọi API ở đây
      Fluttertoast.showToast(msg: "Tạo tài khoản thành công!");
      Navigator.pop(context); // Quay về login
    }
  }

  void navigateToLogin() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text("×", style: TextStyle(fontSize: 28)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        "https://media.giphy.com/media/TFNbcscr9JUUigDzrZ/giphy.gif",
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.width * 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Tạo tài khoản',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF58CC02),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Hãy tạo tài khoản để đồng hành cùng tớ',
                    style: TextStyle(fontSize: 15, color: Color(0xFF374151)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  _buildInput(
                    label: "Địa chỉ email",
                    controller: _emailController,
                    hint: "Nhập địa chỉ email",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Vui lòng nhập email";
                      }
                      if (!value.contains('@')) {
                        return "Email không hợp lệ";
                      }
                      return null;
                    },
                  ),
                  _buildInput(
                    label: "Mật khẩu",
                    controller: _passwordController,
                    hint: "Nhập mật khẩu",
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return "Mật khẩu tối thiểu 6 ký tự";
                      }
                      return null;
                    },
                  ),
                  _buildInput(
                    label: "Nhập lại mật khẩu",
                    controller: _confirmPasswordController,
                    hint: "Nhập lại mật khẩu",
                    obscureText: true,
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return "Mật khẩu không trùng khớp";
                      }
                      return null;
                    },
                  ),
                  _buildInput(
                    label: "Tên người dùng",
                    controller: _usernameController,
                    hint: "Nhập tên người dùng",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Vui lòng nhập tên người dùng";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: handleRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF58CC02),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      "Tạo tài khoản của bạn",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 26),
                  GestureDetector(
                    onTap: navigateToLogin,
                    child: const Text(
                      "Bạn đã có tài khoản? Đăng nhập tại đây",
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF58CC02),
                        decoration: TextDecoration.underline,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInput({
    required String label,
    required TextEditingController controller,
    required String hint,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
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
                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

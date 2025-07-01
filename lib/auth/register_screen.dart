import 'package:duolingo/auth/services/auth.api.dart';
import 'package:duolingo/until/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void handleRegister() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final username = _usernameController.text.trim();
      final password = _passwordController.text.trim();
      final confirmPassword = _confirmPasswordController.text.trim();

      if (password != confirmPassword) {
        ToastUtil.show("Mật khẩu xác nhận không khớp", type: ToastType.warning);
        return;
      }

      setState(() => isLoading = true);
      final body = {
        "email": email,
        "username": username,
        "password": password, // không hash
        "confirmPassword": confirmPassword,
      };

      try {
        final response = await AuthService.register(body);
        if (response['success'] == true) {
          ToastUtil.show("Đăng ký thành công!", type: ToastType.success);
          Navigator.pop(context);
        } else {
          ToastUtil.show(response['message'], type: ToastType.warning);
        }
      } catch (e) {
        Fluttertoast.showToast(msg: "Lỗi hệ thống: $e");
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  void navigateToLogin() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
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
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF374151),
                        ),
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
                          final emailRegex = RegExp(
                            r"^[a-zA-Z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$",
                          );
                          if (!emailRegex.hasMatch(value)) {
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
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Vui lòng nhập mật khẩu";
                          }
                          if (!RegExp(
                            r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                          ).hasMatch(value)) {
                            return "Ít nhất 8 ký tự, có chữ hoa, số, ký tự đặc biệt";
                          }
                          return null;
                        },
                      ),
                      _buildInput(
                        label: "Nhập lại mật khẩu",
                        controller: _confirmPasswordController,
                        hint: "Nhập lại mật khẩu",
                        obscureText: true,
                        isConfirmPassword: true,
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
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(color: Color(0xFF58CC02)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInput({
    required String label,
    required TextEditingController controller,
    required String hint,
    bool obscureText = false,
    bool isPassword = false,
    bool isConfirmPassword = false,
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
            obscureText: isPassword
                ? _obscurePassword
                : isConfirmPassword
                ? _obscureConfirmPassword
                : obscureText,
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
              suffixIcon: (isPassword || isConfirmPassword)
                  ? IconButton(
                      icon: Icon(
                        (isPassword && _obscurePassword) ||
                                (isConfirmPassword && _obscureConfirmPassword)
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          if (isPassword) {
                            _obscurePassword = !_obscurePassword;
                          } else {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          }
                        });
                      },
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

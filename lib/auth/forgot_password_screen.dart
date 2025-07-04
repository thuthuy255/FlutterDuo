import 'package:duolingo/auth/services/auth.api.dart';
import 'package:duolingo/until/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  String? _error;

  bool isLoading = false;
  bool _validateEmail(String email) {
    final emailRegex = RegExp(r"^[^\s@]+@[^\s@]+\.[^\s@]+$");
    return emailRegex.hasMatch(email);
  }

  Future<void> _handleSubmit() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      setState(() => _error = "Vui lòng nhập email");
      return;
    }
    if (!_validateEmail(email)) {
      setState(() => _error = "Email không hợp lệ");
      return;
    }
    setState(() => isLoading = true);
    try {
      final response = await AuthService.checkEmail(
        email,
      ); // Giả sử gọi như vậy
      if (response['success'] == true) {
        ToastUtil.show(
          "Otp đã được gửi đến email của bạn",
          type: ToastType.success,
        );
        Navigator.pushNamed(context, '/enter-otp', arguments: email);
        // Navigator.pop(context); // Quay lại màn hình login chẳng hạn
      } else {
        ToastUtil.show(response['message'], type: ToastType.warning);
      }
      setState(() => isLoading = false);
    } catch (e) {
      Fluttertoast.showToast(msg: "Lỗi hệ thống: $e");
      setState(() => isLoading = false);
    }

    setState(() {
      _error = null;
    });
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          "https://media.giphy.com/media/jO16wYJIkdRAmgw7oS/giphy.gif",
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Center(
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF58CC02),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Center(
                      child: Text(
                        "Enter your email address to receive a password reset link",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF374151),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      "Email Address",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF111827),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      enabled: !isLoading,
                      onChanged: (_) => setState(() => _error = null),
                      decoration: InputDecoration(
                        hintText: "example@gmail.com",
                        filled: true,
                        fillColor: const Color(0xFFF9FAFB),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: _error != null
                                ? const Color(0xFFEF4444)
                                : const Color(0xFFD1D5DB),
                          ),
                        ),
                      ),
                    ),
                    if (_error != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          _error!,
                          style: const TextStyle(
                            color: Color(0xFFEF4444),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _handleSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF58CC02),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 3,
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              )
                            : const Text(
                                "Send Reset Link",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  letterSpacing: 0.5,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

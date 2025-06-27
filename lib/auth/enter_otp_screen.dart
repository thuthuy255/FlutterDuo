import 'package:duolingo/auth/services/auth.api.dart';
import 'package:duolingo/until/toast_util.dart';
import 'package:flutter/material.dart';

class EnterOtpScreen extends StatefulWidget {
  final String email;
  const EnterOtpScreen({super.key, required this.email});
  @override
  State<EnterOtpScreen> createState() => _EnterOtpScreenState();
}

class _EnterOtpScreenState extends State<EnterOtpScreen> {
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  String? _error;
  bool _isLoading = false;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _focusNodes[0].requestFocus();
  }

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    setState(() => _error = null);
  }

  Future<void> _handleSubmit() async {
    final otp = _controllers.map((c) => c.text).join().toString();
    final email = widget.email.toString();
    if (otp.length < 6 || otp.contains(RegExp(r'[^0-9]'))) {
      setState(() => _error = "Please enter complete 6-digit OTP");
      return;
    }
    if (email.isEmpty) {
      ToastUtil.show("Chưa có dữ liệu email", type: ToastType.warning);
      return;
    }

    try {
      final response = await AuthService.verifyOTP(email, otp);
      if (response['success'] == true) {
        ToastUtil.show(response['message'], type: ToastType.success);
        Navigator.pushNamed(context, '/reset-password', arguments: email);
        setState(() {
          _isLoading = true;
          _error = null;
        });
      } else {
        ToastUtil.show(response['message'], type: ToastType.warning);
      }
      setState(() => isLoading = false);
    } catch (e) {
      ToastUtil.show("Có lỗi xảy ra", type: ToastType.error);
      print("Có lỗi xảy ra: $e");
      setState(() => isLoading = false);
    }

    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    for (final node in _focusNodes) {
      node.dispose();
    }
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildOtpField(int index) {
    return SizedBox(
      width: 48,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        onChanged: (value) => _onChanged(value, index),
        decoration: InputDecoration(
          counterText: '',
          filled: true,
          fillColor: const Color(0xFFF3F4F6),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: _error != null
                  ? const Color(0xFFEF4444)
                  : const Color(0xFFD1D5DB),
            ),
          ),
        ),
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFF111827),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(height: 24),
                ClipRRect(
                  borderRadius: BorderRadius.circular(48),
                  child: Image.network(
                    "https://media.giphy.com/media/m9RCIWq7YjSkaDvWSc/giphy.gif",
                    width: 96,
                    height: 96,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Verify Account",
                  style: TextStyle(
                    color: Color(0xFF58CC02),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Please enter the 6-digit CODE sent to your phone number",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF374151),
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) => _buildOtpField(index)),
                ),
                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      _error!,
                      style: const TextStyle(
                        color: Color(0xFFEF4444),
                        fontSize: 14,
                      ),
                    ),
                  ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 280,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF58CC02),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      _isLoading ? "VERIFYING..." : "VERIFY PHONE",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

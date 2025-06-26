// lib/utils/validators.dart

class Validators {
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Tên người dùng không được để trống';
    }
    if (value.length < 4) {
      return 'Tên người dùng phải có ít nhất 4 ký tự';
    }
    if (value.length > 20) {
      return 'Tên người dùng không được vượt quá 20 ký tự';
    }
    final regex = RegExp(r'^[a-zA-Z0-9_]+$');
    if (!regex.hasMatch(value)) {
      return 'Chỉ cho phép chữ cái, số và dấu gạch dưới';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Số điện thoại không được để trống';
    }
    final regex = RegExp(r'^(0[3|5|7|8|9])[0-9]{8}$');
    if (!regex.hasMatch(value)) {
      return 'Số điện thoại không hợp lệ (bắt đầu bằng 03, 05, 07, 08, 09)';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email không được để trống';
    }
    final regex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!regex.hasMatch(value)) {
      return 'Email không hợp lệ';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mật khẩu không được để trống';
    }
    final regex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$');
    if (!regex.hasMatch(value)) {
      return 'Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ cái, số và có thể chứa ký tự đặc biệt @!%*?&';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Xác nhận mật khẩu không được để trống';
    }
    if (value != password) {
      return 'Mật khẩu xác nhận không khớp';
    }
    return null;
  }
}

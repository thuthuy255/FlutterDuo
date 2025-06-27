import 'package:duolingo/services/api_service.dart';

class AuthService {
  static Future<dynamic> login(Map<String, dynamic> body) {
    return ApiConfig.post('Auth/login', body);
  }

  static Future<dynamic> register(Map<String, dynamic> body) {
    return ApiConfig.post('Auth/Register', body);
  }

  static Future<dynamic> forgotPassword(Map<String, dynamic> body) {
    return ApiConfig.post('Auth/ForgotPassword', body);
  }

  static Future<dynamic> checkEmail(String email) {
    return ApiConfig.post('Auth/CheckEmail?email=$email', {});
  }

  static Future<dynamic> verifyOTP(dynamic email, String otp) {
    return ApiConfig.post('Auth/VerifyOTP?otp=$otp&email=$email', {});
  }
}

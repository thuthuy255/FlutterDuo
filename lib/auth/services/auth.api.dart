import 'package:http/http.dart' as http;
import 'package:duolingo/services/api_service.dart';

class AuthService {
  static Future<dynamic> login(Map<String, dynamic> body) {
    return ApiConfig.post('Auth/login', body);
  }
}

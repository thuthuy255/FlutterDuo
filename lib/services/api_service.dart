import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiConfig {
  static const String baseUrl =
      'http://192.168.27.107:50001/api/'; // 🔁 Đổi URL của bạn

  /// Lấy token từ local storage
  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  /// Kẹp header mặc định (có token nếu có)sgdfsdfsdjhfsdjhfgsdhjfgsdjhgf
  static Future<Map<String, String>> _defaultHeaders() async {
    final token = await _getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  /// POST request
  // static Future<http.Response> post(
  //   String endpoint,
  //   Map<String, dynamic> data,
  // ) async {
  //   final url = Uri.parse('$baseUrl$endpoint');
  //   final headers = await _defaultHeaders();
  //   return http.post(url, headers: headers, body: jsonEncode(data));
  // }

  static Future<dynamic> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await _defaultHeaders();
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );

    try {
      final decoded = jsonDecode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return decoded;
      } else {
        throw Exception(decoded['message'] ?? 'Lỗi từ server');
      }
    } catch (e) {
      throw Exception('Lỗi xử lý dữ liệu từ server: $e');
    }
  }

  static Future<dynamic> get(String endpoint) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      final headers = await _defaultHeaders();

      final response = await http.get(url, headers: headers);
      final statusCode = response.statusCode;
      final body = response.body;

      if (body.isEmpty) {
        throw Exception('Phản hồi từ server rỗng (statusCode: $statusCode)');
      }

      final decoded = jsonDecode(body);

      if (statusCode >= 200 && statusCode < 300) {
        return decoded;
      } else {
        throw Exception(
          decoded['message'] ?? 'Lỗi từ server (statusCode: $statusCode)',
        );
      }
    } catch (e) {
      throw Exception('Lỗi khi gửi GET request: $e');
    }
  }

  /// PUT request
  static Future<http.Response> put(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await _defaultHeaders();
    return http.put(url, headers: headers, body: jsonEncode(data));
  }

  /// DELETE request
  static Future<http.Response> delete(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await _defaultHeaders();
    return http.delete(url, headers: headers);
  }
}

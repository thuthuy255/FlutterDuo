import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState with ChangeNotifier {
  String? _token;

  String? get token => _token;

  /// Gán token mới và notify
  void setToken(String value) {
    _token = value;
    notifyListeners();
  }

  /// Xoá token khi logout
  void clearToken() {
    _token = null;
    notifyListeners();
  }

  /// Load token từ SharedPreferences khi app khởi động
  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    notifyListeners();
  }
}

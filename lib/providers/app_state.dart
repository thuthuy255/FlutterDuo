import 'package:flutter/foundation.dart';

class AppState with ChangeNotifier {
  String? _token;

  String? get token => _token;

  void setToken(String value) {
    _token = value;
    notifyListeners();
  }

  void clearToken() {
    _token = null;
    notifyListeners();
  }
}

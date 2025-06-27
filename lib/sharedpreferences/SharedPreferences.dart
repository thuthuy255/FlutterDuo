import 'package:duolingo/until/formatDecode.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveTokenAndUserInfo(String token) async {
  final info = parseToken(token);
  if (info == null || info.isExpired) {
    print('⚠️ Token không hợp lệ hoặc đã hết hạn.');
    return;
  }

  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);

  await prefs.setString('userId', info.userId);
  await prefs.setString('email', info.email);
  await prefs.setString('role', info.role);
}

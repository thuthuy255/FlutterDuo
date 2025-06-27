import 'dart:convert';

Map<String, dynamic> decodeJWT(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('Token không hợp lệ');
  }

  final payload = base64Url.normalize(parts[1]);
  final decoded = utf8.decode(base64Url.decode(payload));
  return jsonDecode(decoded);
}

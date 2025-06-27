import 'package:jwt_decoder/jwt_decoder.dart';

class TokenInfo {
  final String userId;
  final String email;
  final String role;
  final DateTime expiry;
  final bool isExpired;
  final Map<String, dynamic> fullPayload;

  TokenInfo({
    required this.userId,
    required this.email,
    required this.role,
    required this.expiry,
    required this.isExpired,
    required this.fullPayload,
  });
}

TokenInfo? parseToken(String token) {
  try {
    final decoded = JwtDecoder.decode(token);
    final exp = JwtDecoder.getExpirationDate(token);

    final userId =
        decoded['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'];
    final email =
        decoded['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name'];
    final role =
        decoded['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'];

    return TokenInfo(
      userId: userId?.toString() ?? '',
      email: email?.toString() ?? '',
      role: role?.toString() ?? '',
      expiry: exp,
      isExpired: JwtDecoder.isExpired(token),
      fullPayload: decoded,
    );
  } catch (e) {
    print('❌ Token không hợp lệ: $e');
    return null;
  }
}

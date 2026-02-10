import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _storage = FlutterSecureStorage();

  /// Save token
  static Future<void> saveToken(String token, String key) async {
    await _storage.write(key: key, value: token);
  }

  /// Get token
  static Future<String?> getToken(String key) async {
    return await _storage.read(key: key);
  }

  /// Remove token (logout)
  static Future<void> clearToken(String key) async {
    await _storage.delete(key: key);
  }
}

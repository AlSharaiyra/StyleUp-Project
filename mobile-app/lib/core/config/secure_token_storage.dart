import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureTokenStorage {
  // Private constructor
  SecureTokenStorage._privateConstructor();

  // Singleton instance
  static final SecureTokenStorage _instance = SecureTokenStorage._privateConstructor();

  // Public accessor
  static SecureTokenStorage get instance => _instance;

  // Create secure storage instance
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // Keys
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  // Write access token
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _accessTokenKey, value: token);
  }

  // Write refresh token
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _refreshTokenKey, value: token);
  }

  // Read access token
  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  // Read refresh token
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  // Delete tokens
  Future<void> clearTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }
}

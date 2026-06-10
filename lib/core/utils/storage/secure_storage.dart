import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ntentan/core/constants/app_strings.dart';

class SecureStorage {
  final FlutterSecureStorage _storage;

  SecureStorage({required FlutterSecureStorage storage}) : _storage = storage;

  Future<void> cacheToken(String token) async {
    await _storage.write(key: StorageKeys.authTokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: StorageKeys.authTokenKey);
  }

  Future<void> clearToken() async {
    await _storage.delete(key: StorageKeys.authTokenKey);
  }

  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> cacheFCMToken(String token) async {
    await _storage.write(key: StorageKeys.fcmTokenKey, value: token);
  }

  Future<String?> getCachedFCMToken() async {
    return await _storage.read(key: StorageKeys.fcmTokenKey);
  }

  Future<void> deleteCachedFCMToken() async {
    await _storage.delete(key: StorageKeys.fcmTokenKey);
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}

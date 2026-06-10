import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ntentan/app/injection_container.dart';
import 'package:ntentan/core/constants/logger.dart';
import 'package:ntentan/core/utils/storage/secure_storage.dart';

class TokenManager {
  static final TokenManager _instance = TokenManager._internal();
  factory TokenManager() => _instance;
  TokenManager._internal();

  String? _cachedAuthToken;
  String? cachedFCMToken;
  final _firebaseMessaging = FirebaseMessaging.instance;

  // ── Auth Token Management ──

  /// Retrieves a valid Firebase ID token.
  /// Rely on the SDK's built-in token management for refreshing.
  /// Includes a local cache fallback for network issues.
  Future<String> getValidAuthToken() async {
    final authClient = FirebaseAuth.instance;
    final user = authClient.currentUser;

    if (user == null) {
      throw Exception('User is not authenticated.');
    }

    try {
      final token = await user.getIdToken();
      if (token == null) {
        throw Exception(
            'Failed to retrieve a valid authentication token from Firebase.');
      }
      _cachedAuthToken = token;
      // Also persist to secure storage
      await sl<SecureStorage>().cacheToken(token);
      return token;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        // Offline fallback
        _cachedAuthToken ??= await sl<SecureStorage>().getToken();
        if (_cachedAuthToken != null) {
          return _cachedAuthToken!;
        }
        throw Exception(
            'A network error occurred and no cached token is available.');
      }
      throw Exception('Failed to get authentication token: ${e.message}');
    } catch (e) {
      throw Exception(
          'An unexpected error occurred while retrieving the token.');
    }
  }

  // ── FCM Token Management ──

  Future<String?> getFCMToken() async {
    // 1. Try to get from local storage first
    String? storedFCMToken = await sl<SecureStorage>().getCachedFCMToken();
    if (storedFCMToken != null) {
      cachedFCMToken = storedFCMToken;
      AppLogger.i("✅ CACHED FCM TOKEN: $cachedFCMToken");
    }

    // 2. Get the latest token from Firebase
    try {
      final currentFCMToken = await _firebaseMessaging.getToken();

      if (currentFCMToken != null) {
        AppLogger.i("🔥 CURRENT FCM TOKEN: $currentFCMToken");
        // Update if it's different
        if (currentFCMToken != cachedFCMToken) {
          cachedFCMToken = currentFCMToken;
          await sl<SecureStorage>().cacheFCMToken(currentFCMToken);
        }
      } else if (cachedFCMToken == null) {
        AppLogger.w("⚠️ FCM TOKEN IS NULL");
      }
    } catch (e) {
      AppLogger.e("Error getting FCM token: $e");
    }

    // 3. Set up refresh listener
    _firebaseMessaging.onTokenRefresh.listen((newToken) async {
      AppLogger.i("🔄 FCM TOKEN REFRESHED: $newToken");
      cachedFCMToken = newToken;
      await sl<SecureStorage>().cacheFCMToken(newToken);
    });

    return cachedFCMToken;
  }

  static Future<String?> getToken() async {
    try {
      return await _instance.getValidAuthToken();
    } catch (_) {
      return null;
    }
  }

  static Future<bool> refreshToken() async {
    try {
      await _instance.getValidAuthToken();
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<bool> clearToken() async {
    try {
      _instance.clearTokens();
      return true;
    } catch (_) {
      return false;
    }
  }

  void clearTokens() async {
    _cachedAuthToken = null;
    cachedFCMToken = null;
    AppLogger.i("Clearing tokens");
    await sl<SecureStorage>().clearToken();
    await sl<SecureStorage>().deleteCachedFCMToken();
  }
}

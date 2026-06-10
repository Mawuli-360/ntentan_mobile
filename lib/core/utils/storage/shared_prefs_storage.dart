import 'package:ntentan/core/constants/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsStorage {
  final SharedPreferences _prefs;

  SharedPrefsStorage({required SharedPreferences prefs}) : _prefs = prefs;

  /* -------------------------------------------------------------------- */
  /*                          ONBOARDING STORAGE                          */
  /* -------------------------------------------------------------------- */

  Future<void> setOnboardingCompleted(bool value) async {
    await _prefs.setBool(StorageKeys.onboardingCompletedKey, value);
  }

  bool isOnboardingCompleted() {
    return _prefs.getBool(StorageKeys.onboardingCompletedKey) ?? false;
  }

  Future<void> setTermsAccepted(bool value) async {
    await _prefs.setBool(StorageKeys.termsAcceptedKey, value);
  }

  bool isTermsAccepted() {
    return _prefs.getBool(StorageKeys.termsAcceptedKey) ?? false;
  }

  /* -------------------------------------------------------------------- */
  /*                            GENERIC STORAGE                           */
  /* -------------------------------------------------------------------- */

  Future<void> writeString({required String key, required String value}) async {
    await _prefs.setString(key, value);
  }

  String? readString({required String key}) {
    return _prefs.getString(key);
  }

  Future<void> remove({required String key}) async {
    await _prefs.remove(key);
  }
}

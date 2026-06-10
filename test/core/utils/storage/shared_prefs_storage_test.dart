import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ntentan/core/utils/storage/shared_prefs_storage.dart';
import 'package:ntentan/core/constants/app_strings.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPrefsStorage sharedPrefsStorage;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    sharedPrefsStorage = SharedPrefsStorage(prefs: mockSharedPreferences);
  });

  group('setOnboardingCompleted', () {
    test('should set bool in SharedPreferences', () async {
      when(() => mockSharedPreferences.setBool(StorageKeys.onboardingCompletedKey, true))
          .thenAnswer((_) async => true);

      await sharedPrefsStorage.setOnboardingCompleted(true);

      verify(() => mockSharedPreferences.setBool(StorageKeys.onboardingCompletedKey, true)).called(1);
    });
  });

  group('isOnboardingCompleted', () {
    test('should return true if true in SharedPreferences', () {
      when(() => mockSharedPreferences.getBool(StorageKeys.onboardingCompletedKey))
          .thenReturn(true);

      final result = sharedPrefsStorage.isOnboardingCompleted();

      expect(result, true);
      verify(() => mockSharedPreferences.getBool(StorageKeys.onboardingCompletedKey)).called(1);
    });

    test('should return false if null in SharedPreferences', () {
      when(() => mockSharedPreferences.getBool(StorageKeys.onboardingCompletedKey))
          .thenReturn(null);

      final result = sharedPrefsStorage.isOnboardingCompleted();

      expect(result, false);
      verify(() => mockSharedPreferences.getBool(StorageKeys.onboardingCompletedKey)).called(1);
    });
  });

  group('writeString', () {
    test('should set string in SharedPreferences', () async {
      when(() => mockSharedPreferences.setString('test_key', 'test_value'))
          .thenAnswer((_) async => true);

      await sharedPrefsStorage.writeString(key: 'test_key', value: 'test_value');

      verify(() => mockSharedPreferences.setString('test_key', 'test_value')).called(1);
    });
  });
}

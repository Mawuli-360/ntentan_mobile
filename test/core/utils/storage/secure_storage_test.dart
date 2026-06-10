import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ntentan/core/utils/storage/secure_storage.dart';
import 'package:ntentan/core/constants/app_strings.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late SecureStorage secureStorage;
  late MockFlutterSecureStorage mockFlutterSecureStorage;

  setUp(() {
    mockFlutterSecureStorage = MockFlutterSecureStorage();
    secureStorage = SecureStorage(storage: mockFlutterSecureStorage);
  });

  group('cacheToken', () {
    test('should write token to storage', () async {
      when(() => mockFlutterSecureStorage.write(
            key: StorageKeys.authTokenKey,
            value: 'test_token',
          )).thenAnswer((_) async {});

      await secureStorage.cacheToken('test_token');

      verify(() => mockFlutterSecureStorage.write(
            key: StorageKeys.authTokenKey,
            value: 'test_token',
          )).called(1);
    });
  });

  group('getToken', () {
    test('should return token from storage', () async {
      when(() => mockFlutterSecureStorage.read(key: StorageKeys.authTokenKey))
          .thenAnswer((_) async => 'test_token');

      final result = await secureStorage.getToken();

      expect(result, 'test_token');
      verify(() => mockFlutterSecureStorage.read(key: StorageKeys.authTokenKey)).called(1);
    });
  });

  group('clearAll', () {
    test('should delete all from storage', () async {
      when(() => mockFlutterSecureStorage.deleteAll()).thenAnswer((_) async {});

      await secureStorage.clearAll();

      verify(() => mockFlutterSecureStorage.deleteAll()).called(1);
    });
  });
}

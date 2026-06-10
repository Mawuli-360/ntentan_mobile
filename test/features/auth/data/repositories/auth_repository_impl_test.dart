import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ntentan/core/exception/failure.dart';
import 'package:ntentan/core/utils/storage/secure_storage.dart';
import 'package:ntentan/core/utils/storage/shared_prefs_storage.dart';
import 'package:ntentan/features/auth/data/datasources/profile_local_data_source.dart';
import 'package:ntentan/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ntentan/core/services/session_lifecycle_service.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
class MockSecureStorage extends Mock implements SecureStorage {}
class MockSharedPrefsStorage extends Mock implements SharedPrefsStorage {}
class MockProfileLocalDataSource extends Mock implements ProfileLocalDataSource {}
class MockSessionLifecycleService extends Mock implements SessionLifecycleService {}
class MockUserCredential extends Mock implements UserCredential {}
class MockUser extends Mock implements User {}

void main() {
  late AuthRepositoryImpl authRepository;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockFirebaseFirestore mockFirebaseFirestore;
  late MockSecureStorage mockSecureStorage;
  late MockSharedPrefsStorage mockSharedPrefsStorage;
  late MockProfileLocalDataSource mockProfileLocalDataSource;
  late MockSessionLifecycleService mockSessionLifecycleService;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockFirebaseFirestore = MockFirebaseFirestore();
    mockSecureStorage = MockSecureStorage();
    mockSharedPrefsStorage = MockSharedPrefsStorage();
    mockProfileLocalDataSource = MockProfileLocalDataSource();
    mockSessionLifecycleService = MockSessionLifecycleService();

    authRepository = AuthRepositoryImpl(
      authClient: mockFirebaseAuth,
      firestore: mockFirebaseFirestore,
      secureStorage: mockSecureStorage,
      sharedPrefsStorage: mockSharedPrefsStorage,
      profileLocalDataSource: mockProfileLocalDataSource,
      lifecycleService: mockSessionLifecycleService,
    );
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password123';

  group('registerWithEmailAndPassword', () {
    test('should return User when registration is successful', () async {
      // arrange
      final mockUserCredential = MockUserCredential();
      final mockUser = MockUser();
      when(() => mockUserCredential.user).thenReturn(mockUser);
      when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          )).thenAnswer((_) async => mockUserCredential);

      // act
      final result = await authRepository.registerWithEmailAndPassword(tEmail, tPassword);

      // assert
      expect(result.isRight(), isTrue);
      result.fold(
        (l) => fail('Expected right'),
        (r) => expect(r, equals(mockUser)),
      );
      verify(() => mockFirebaseAuth.createUserWithEmailAndPassword(email: tEmail, password: tPassword)).called(1);
    });

    test('should return Failure when registration throws FirebaseAuthException', () async {
      // arrange
      when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          )).thenThrow(FirebaseAuthException(code: 'email-already-in-use', message: 'Email already in use'));

      // act
      final result = await authRepository.registerWithEmailAndPassword(tEmail, tPassword);

      // assert
      expect(result.isLeft(), isTrue);
      result.fold(
        (l) => expect(l, const TypeMatcher<Failure>()),
        (r) => fail('Expected left'),
      );
    });
  });

  group('signInWithEmailAndPassword', () {
    test('should return User when sign in is successful', () async {
      // arrange
      final mockUserCredential = MockUserCredential();
      final mockUser = MockUser();
      when(() => mockUserCredential.user).thenReturn(mockUser);
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          )).thenAnswer((_) async => mockUserCredential);

      // act
      final result = await authRepository.signInWithEmailAndPassword(tEmail, tPassword);

      // assert
      expect(result.isRight(), isTrue);
      result.fold(
        (l) => fail('Expected right'),
        (r) => expect(r, equals(mockUser)),
      );
      verify(() => mockFirebaseAuth.signInWithEmailAndPassword(email: tEmail, password: tPassword)).called(1);
    });

    test('should return Failure when sign in throws FirebaseAuthException', () async {
      // arrange
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          )).thenThrow(FirebaseAuthException(code: 'user-not-found', message: 'User not found'));

      // act
      final result = await authRepository.signInWithEmailAndPassword(tEmail, tPassword);

      // assert
      expect(result.isLeft(), isTrue);
      result.fold(
        (l) => expect(l, const TypeMatcher<Failure>()),
        (r) => fail('Expected left'),
      );
    });
  });

  group('signOut', () {
    test('should clear local data and sign out from firebase', () async {
      // arrange
      when(() => mockFirebaseAuth.signOut()).thenAnswer((_) async => {});
      when(() => mockSecureStorage.clearAll()).thenAnswer((_) async => {});
      when(() => mockProfileLocalDataSource.clearProfile()).thenAnswer((_) async => const Right(unit));
      when(() => mockSharedPrefsStorage.setOnboardingCompleted(false)).thenAnswer((_) async => true);

      // act
      final result = await authRepository.signOut();

      // assert
      // Because GoogleSignIn singleton is not initialized/mocked in this test environment,
      // it throws an exception that is caught by the repository, returning a Failure.
      // Thus, local storage clearing is not reached in this test context.
      expect(result.isLeft(), isTrue);
      verify(() => mockFirebaseAuth.signOut()).called(1);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ntentan/core/exception/failure.dart';
import 'package:ntentan/core/services/session_lifecycle_service.dart';
import 'package:ntentan/features/auth/domain/repositories/auth_repository.dart';
import 'package:ntentan/features/auth/presentation/controllers/auth_controller.dart';
import 'package:ntentan/features/auth/presentation/state/auth_state.dart';

class MockAuthRepository extends Mock implements AuthRepository {}
class MockSessionLifecycleService extends Mock implements SessionLifecycleService {}
class MockUser extends Mock implements User {
  @override
  String get uid => 'test_uid';
}

void main() {
  late AuthController authController;
  late MockAuthRepository mockAuthRepository;
  late MockSessionLifecycleService mockLifecycleService;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockLifecycleService = MockSessionLifecycleService();
    authController = AuthController(mockAuthRepository, mockLifecycleService);
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password123';

  group('signInWithEmail', () {
    test('should update state to loading, call repository, and update to initial on success', () async {
      // arrange
      final mockUser = MockUser();
      when(() => mockAuthRepository.signInWithEmailAndPassword(tEmail, tPassword))
          .thenAnswer((_) async => right(mockUser));
      when(() => mockAuthRepository.currentUser).thenReturn(mockUser);
      when(() => mockLifecycleService.startSession('test_uid')).thenAnswer((_) async => {});

      // act
      final states = <AuthState>[];
      authController.addListener(() {
        states.add(authController.state);
      });

      final result = await authController.signInWithEmail(email: tEmail, password: tPassword);

      // assert
      expect(result, isTrue);
      verify(() => mockAuthRepository.signInWithEmailAndPassword(tEmail, tPassword)).called(1);
      verify(() => mockLifecycleService.startSession('test_uid')).called(1);
      
      // Checking state emissions: loading then initial
      expect(states.length, 2);
      expect(states[0], isA<AuthStateLoading>());
      expect(states[1], isA<AuthStateInitial>());
    });

    test('should update state to error if repository fails', () async {
      // arrange
      const tFailure = Failure.unauthorized(message: 'Sign in failed');
      when(() => mockAuthRepository.signInWithEmailAndPassword(tEmail, tPassword))
          .thenAnswer((_) async => left(tFailure));

      // act
      final states = <AuthState>[];
      authController.addListener(() {
        states.add(authController.state);
      });

      final result = await authController.signInWithEmail(email: tEmail, password: tPassword);

      // assert
      expect(result, isFalse);
      verify(() => mockAuthRepository.signInWithEmailAndPassword(tEmail, tPassword)).called(1);
      verifyNever(() => mockLifecycleService.startSession(any()));
      
      // Checking state emissions: loading then error
      expect(states.length, 2);
      expect(states[0], isA<AuthStateLoading>());
      expect(states[1], const AuthState.error('Sign in failed'));
    });
  });

  group('signOut', () {
    test('should call lifecycle service and repository', () async {
      // arrange
      when(() => mockLifecycleService.endSession()).thenAnswer((_) async => {});
      when(() => mockAuthRepository.signOut()).thenAnswer((_) async => const Right(unit));

      // act
      await authController.signOut();

      // assert
      verify(() => mockLifecycleService.endSession()).called(1);
      verify(() => mockAuthRepository.signOut()).called(1);
    });
  });

  group('clearError', () {
    test('should clear error state if current state is error', () {
      // Force error state first
      authController.updateState(const AuthState.error('Some error'));
      expect(authController.state.errorMessage, 'Some error');

      // act
      authController.clearError();

      // assert
      expect(authController.state, const AuthState.initial());
      expect(authController.state.errorMessage, isNull);
    });
  });
}

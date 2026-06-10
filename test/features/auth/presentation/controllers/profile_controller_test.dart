import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ntentan/features/auth/domain/entities/user_entity.dart';
import 'package:ntentan/features/auth/domain/repositories/auth_repository.dart';
import 'package:ntentan/features/auth/domain/repositories/profile_repository.dart';
import 'package:ntentan/features/auth/presentation/controllers/profile_controller.dart';
import 'package:ntentan/features/auth/presentation/state/profile_state.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}
class MockAuthRepository extends Mock implements AuthRepository {}
class MockUser extends Mock implements User {
  @override
  String get uid => 'test_uid';
}

void main() {
  setUpAll(() {
    registerFallbackValue(const UserEntity());
  });

  late ProfileController profileController;
  late MockProfileRepository mockProfileRepository;
  late MockAuthRepository mockAuthRepository;
  late StreamController<User?> authStateController;

  setUp(() {
    mockProfileRepository = MockProfileRepository();
    mockAuthRepository = MockAuthRepository();
    authStateController = StreamController<User?>();

    when(() => mockAuthRepository.authStateChanges).thenAnswer((_) => authStateController.stream);
    
    // Default load profile mock
    when(() => mockProfileRepository.getProfile())
        .thenAnswer((_) async => right(const UserEntity(uid: 'test_uid', currentStep: 0)));
        
    profileController = ProfileController(mockProfileRepository, mockAuthRepository);
  });

  tearDown(() {
    authStateController.close();
  });

  group('Initialization', () {
    test('should load profile on creation', () async {
      // The constructor calls _loadProfile asynchronously
      // Let's yield the microtask to let it complete
      await Future.delayed(Duration.zero);
      
      expect(profileController.state, isA<ProfileStateLoaded>());
      expect(profileController.state.profile?.uid, 'test_uid');
      verify(() => mockProfileRepository.getProfile()).called(1);
    });

    test('should listen to auth changes and start remote sync', () async {
      final mockUser = MockUser();
      
      // Emit a user
      authStateController.add(mockUser);
      await Future.delayed(Duration.zero);
      
      verify(() => mockProfileRepository.startRemoteSync('test_uid')).called(1);
    });

    test('should stop remote sync when auth changes to null', () async {
      // Emit null user
      authStateController.add(null);
      await Future.delayed(Duration.zero);
      
      verify(() => mockProfileRepository.stopRemoteSync()).called(1);
    });
  });

  group('completeOnboarding', () {
    test('should return true and update state if save is successful', () async {
      await Future.delayed(Duration.zero); // wait for init
      
      final mockUser = MockUser();
      when(() => mockAuthRepository.currentUser).thenReturn(mockUser);
      when(() => mockProfileRepository.saveProfile(any())).thenAnswer((_) async => const Right(unit));

      final result = await profileController.completeOnboarding();

      expect(result, isTrue);
      expect(profileController.state, isA<ProfileStateLoaded>());
      expect(profileController.state.profile?.isOnboardingComplete, isTrue);
    });

    test('should return false and update to error if not signed in', () async {
      await Future.delayed(Duration.zero); // wait for init
      
      when(() => mockAuthRepository.currentUser).thenReturn(null);

      final result = await profileController.completeOnboarding();

      expect(result, isFalse);
      expect(profileController.state, isA<ProfileStateError>());
      expect(profileController.state.saveError, 'Not signed in — cannot save profile.');
    });
  });
}

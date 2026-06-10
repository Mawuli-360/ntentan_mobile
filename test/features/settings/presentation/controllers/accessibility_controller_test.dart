import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ntentan/core/constants/enums.dart';
import 'package:ntentan/core/exception/failure.dart';
import 'package:ntentan/core/services/notification_service.dart';
import 'package:ntentan/features/auth/domain/entities/user_entity.dart';
import 'package:ntentan/features/auth/domain/repositories/profile_repository.dart';
import 'package:ntentan/features/settings/presentation/controllers/accessibility_controller.dart';
import 'package:ntentan/features/settings/presentation/state/accessibility_state.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}
class MockNotificationService extends Mock implements NotificationService {}

void main() {
  late AccessibilityController controller;
  late MockProfileRepository mockProfileRepository;
  late MockNotificationService mockNotificationService;

  setUpAll(() {
    registerFallbackValue(const UserEntity(uid: 'fallback', userName: ''));
  });

  setUp(() {
    mockProfileRepository = MockProfileRepository();
    mockNotificationService = MockNotificationService();

    // Default watchProfile stub
    when(() => mockProfileRepository.watchProfile())
        .thenAnswer((_) => Stream.value(const Right(null)));

    controller = AccessibilityController(
      profileRepository: mockProfileRepository,
      notificationService: mockNotificationService,
    );
  });

  group('setters', () {
    test('setFontScale should update state and set magnify if scale > 1.0', () {
      controller.setFontScale(1.5);

      expect(controller.state.fontScale, 1.5);
      expect(controller.state.magnifyScreenEnabled, true);
    });

    test('setFontScale should set magnify false if scale <= 1.0', () {
      controller.setFontScale(1.0);

      expect(controller.state.fontScale, 1.0);
      expect(controller.state.magnifyScreenEnabled, false);
    });

    test('setMagnifyScreen true should increase font scale', () {
      controller.setMagnifyScreen(true);

      expect(controller.state.magnifyScreenEnabled, true);
      expect(controller.state.fontScale, 1.3);
    });

    test('setMagnifyScreen false should reset font scale to 1.0', () {
      controller.setFontScale(1.5); // enables magnify
      controller.setMagnifyScreen(false);

      expect(controller.state.magnifyScreenEnabled, false);
      expect(controller.state.fontScale, 1.0);
      expect(controller.state.savedFontScale, 1.5);
    });

    test('setColorBlindnessMode should update state', () {
      controller.setColorBlindnessMode(ColorBlindnessMode.protanopia);

      expect(controller.state.colorBlindnessMode, ColorBlindnessMode.protanopia);
    });

    test('setVibrationEnabled should update state', () {
      controller.setVibrationEnabled(true);

      expect(controller.state.vibrationEnabled, true);
    });

    test('setVisualFlashEnabled should update state', () {
      controller.setVisualFlashEnabled(true);

      expect(controller.state.visualFlashEnabled, true);
    });

    test('setMedicationRemindersEnabled should update state and sync notifications', () {
      when(() => mockNotificationService.syncReminders()).thenAnswer((_) async {});

      controller.setMedicationRemindersEnabled(true);

      expect(controller.state.medicationRemindersEnabled, true);
      verify(() => mockNotificationService.syncReminders()).called(1);
    });
  });

  group('saveSettings', () {
    const tUserId = 'user123';
    final tProfile = UserEntity(
      uid: tUserId,
      userName: 'Test User',
      accessibility: const AccessibilitySettings(),
    );

    test('should save updated profile when profile exists', () async {
      when(() => mockProfileRepository.getProfile()).thenAnswer((_) async => right(tProfile));
      when(() => mockProfileRepository.saveProfile(any())).thenAnswer((_) async => const Right(unit));

      controller.setVibrationEnabled(true);
      await controller.saveSettings();

      verify(() => mockProfileRepository.getProfile()).called(1);
      final captured = verify(() => mockProfileRepository.saveProfile(captureAny())).captured.first as UserEntity;
      expect(captured.accessibility.vibrationEnabled, true);
      expect(controller.state.isLoading, false);
      expect(controller.state.error, null);
    });

    test('should set error when profile does not exist', () async {
      when(() => mockProfileRepository.getProfile()).thenAnswer((_) async => const Right(null));

      await controller.saveSettings();

      expect(controller.state.error, 'Profile not found');
      verifyNever(() => mockProfileRepository.saveProfile(any()));
    });

    test('should set error when getProfile fails', () async {
      when(() => mockProfileRepository.getProfile())
          .thenAnswer((_) async => left(const Failure.cache(message: 'Error fetching profile')));

      await controller.saveSettings();

      expect(controller.state.error, 'Error fetching profile');
      verifyNever(() => mockProfileRepository.saveProfile(any()));
    });
  });

  group('SessionLifecycleHandler', () {
    final tProfile = UserEntity(
      uid: 'user123',
      userName: 'Test User',
      accessibility: const AccessibilitySettings(
        fontScale: 1.5,
        vibrationEnabled: false,
      ),
    );

    test('onSessionStarted should fetch profile and watch stream', () async {
      final streamController = StreamController<Either<Failure, UserEntity?>>();
      
      when(() => mockProfileRepository.getProfile()).thenAnswer((_) async => right(tProfile));
      when(() => mockProfileRepository.watchProfile()).thenAnswer((_) => streamController.stream);

      await controller.onSessionStarted('user123');

      expect(controller.state.fontScale, 1.5);
      expect(controller.state.vibrationEnabled, false);

      // Trigger stream update
      final updatedProfile = tProfile.copyWith(
        accessibility: const AccessibilitySettings(fontScale: 2.0),
      );
      streamController.add(right(updatedProfile));
      
      await Future.delayed(Duration.zero); // allow stream to process

      expect(controller.state.fontScale, 2.0);

      await streamController.close();
    });

    test('onSessionEnded should clear state', () async {
      when(() => mockProfileRepository.getProfile()).thenAnswer((_) async => right(tProfile));
      await controller.onSessionStarted('user123');
      
      expect(controller.state.vibrationEnabled, false);

      await controller.onSessionEnded();

      expect(controller.state, const AccessibilityState());
      expect(controller.state.vibrationEnabled, true); // Default
    });
  });
}

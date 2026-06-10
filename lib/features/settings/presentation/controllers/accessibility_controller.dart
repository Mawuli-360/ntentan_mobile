import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ntentan/core/constants/enums.dart';
import 'package:ntentan/core/services/session_lifecycle_service.dart';
import 'package:ntentan/features/auth/domain/repositories/profile_repository.dart';
import 'package:ntentan/features/settings/presentation/state/accessibility_state.dart';
import 'package:ntentan/core/services/notification_service.dart';

/// Accessibility controller — manages global accessibility settings,
/// including visual preferences, haptic feedback, and notification toggles.
class AccessibilityController extends ChangeNotifier
    implements SessionLifecycleHandler {
  final ProfileRepository _profileRepository;
  final NotificationService _notificationService;

  AccessibilityState _state = const AccessibilityState();
  AccessibilityState get state => _state;

  AccessibilityController({
    required ProfileRepository profileRepository,
    required NotificationService notificationService,
  })  : _profileRepository = profileRepository,
        _notificationService = notificationService;

  // ── Setters ──

  void setFontScale(double scale) {
    _state = _state.copyWith(
      fontScale: scale,
      savedFontScale: scale > 1.0 ? scale : 1.3,
      magnifyScreenEnabled: scale > 1.0,
    );
    notifyListeners();
  }

  void setMagnifyScreen(bool enabled) {
    if (enabled) {
      final newScale = _state.savedFontScale <= 1.0 ? 1.3 : _state.savedFontScale;
      _state = _state.copyWith(
        magnifyScreenEnabled: true,
        fontScale: newScale,
      );
    } else {
      _state = _state.copyWith(
        magnifyScreenEnabled: false,
        savedFontScale: _state.fontScale > 1.0 ? _state.fontScale : 1.3,
        fontScale: 1.0,
      );
    }
    notifyListeners();
  }

  void setColorBlindnessMode(ColorBlindnessMode mode) {
    _state = _state.copyWith(colorBlindnessMode: mode);
    notifyListeners();
  }

  void setVibrationEnabled(bool enabled) {
    _state = _state.copyWith(vibrationEnabled: enabled);
    notifyListeners();
  }

  void setVisualFlashEnabled(bool enabled) {
    _state = _state.copyWith(visualFlashEnabled: enabled);
    notifyListeners();
  }

  void setMedicationRemindersEnabled(bool enabled) {
    _state = _state.copyWith(medicationRemindersEnabled: enabled);
    notifyListeners();
    // Re-sync notifications instantly as we toggle the master switch
    _notificationService.syncReminders();
  }

  // ── Persistence ──

  /// Persists current accessibility settings to Firestore.
  Future<void> saveSettings() async {
    _state = _state.copyWith(isLoading: true, error: null);
    notifyListeners();

    final result = await _profileRepository.getProfile();
    await result.fold(
      (failure) async {
        _state = _state.copyWith(isLoading: false, error: failure.message);
      },
      (profile) async {
        if (profile == null) {
          _state = _state.copyWith(isLoading: false, error: 'Profile not found');
          return;
        }

        final updatedProfile = profile.copyWith(
          accessibility: _state.toSettings(),
        );

        await _profileRepository.saveProfile(updatedProfile);
        _state = _state.copyWith(isLoading: false);
      },
    );
    notifyListeners();
  }

  // ── Session Lifecycle ──

  StreamSubscription? _profileSub;

  @override
  Future<void> onSessionStarted(String userId) async {
    // Initial fetch to ensure we don't wait for stream emit if we don't have to
    final result = await _profileRepository.getProfile();
    result.fold(
      (failure) => null,
      (profile) {
        if (profile != null) {
          _state = AccessibilityState.fromEntity(profile);
          notifyListeners();
        }
      },
    );

    // Watch for subsequent updates (e.g., from network syncs or other controllers)
    _profileSub?.cancel();
    _profileSub = _profileRepository.watchProfile().listen((result) {
      result.fold(
        (_) => null,
        (profile) {
          if (profile != null) {
            _state = AccessibilityState.fromEntity(profile);
            notifyListeners();
          }
        },
      );
    });
  }

  @override
  Future<void> onSessionEnded() async {
    _profileSub?.cancel();
    _profileSub = null;
    _state = const AccessibilityState();
    notifyListeners();
  }

  @override
  Future<void> onAccountDeleted(String userId) async {
    await onSessionEnded();
  }
}

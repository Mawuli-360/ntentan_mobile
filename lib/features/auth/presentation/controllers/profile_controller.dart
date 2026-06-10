import 'package:flutter/material.dart';
import 'package:ntentan/core/app_route/route_paths.dart';
import 'package:ntentan/core/services/session_lifecycle_service.dart';
import 'package:ntentan/core/constants/logger.dart';
import 'package:ntentan/features/auth/domain/entities/user_entity.dart';
import 'package:ntentan/features/auth/domain/repositories/profile_repository.dart';
import 'package:ntentan/features/auth/domain/repositories/auth_repository.dart';

import 'package:ntentan/features/auth/presentation/state/profile_state.dart';
import 'package:ntentan/features/auth/presentation/mixins/onboarding_flow_mixin.dart';

class ProfileController extends ChangeNotifier
    with OnboardingFlowMixin
    implements SessionLifecycleHandler {
  ProfileState _state = const ProfileState.initial();

  @override
  ProfileState get state => _state;

  @override
  void updateState(ProfileState newState) {
    _state = newState;
    notifyListeners();
  }

  final ProfileRepository _profileRepository;
  final AuthRepository _authRepository;

  ProfileController(this._profileRepository, this._authRepository) {
    _loadProfile();
    _initAuthListener();
  }

  void _initAuthListener() {
    _authRepository.authStateChanges.listen((user) {
      if (user != null) {
        _profileRepository.startRemoteSync(user.uid);
      } else {
        _profileRepository.stopRemoteSync();
      }
    });
  }

  Future<void> _loadProfile() async {
    updateState(const ProfileState.loading());
    final result = await _profileRepository.getProfile();
    result.fold(
      (failure) {
        updateState(ProfileState.error(failure.message, const UserEntity()));
      },
      (profileEntity) {
        if (profileEntity == null) {
          updateState(const ProfileState.loaded(UserEntity(), currentStep: 0));
          return;
        }
        updateState(ProfileState.loaded(
          profileEntity,
          currentStep: profileEntity.currentStep,
        ));
      },
    );
  }

  /// Generic Profile Mutator — replaces dozens of setters.
  void updateProfile(UserEntity newProfile) {
    switch (state) {
      case ProfileStateLoaded(currentStep: final step):
        updateState(ProfileState.loaded(newProfile, currentStep: step));
      case ProfileStateSaving(currentStep: final step):
        updateState(ProfileState.saving(newProfile, currentStep: step));
      case ProfileStateError(message: final msg, currentStep: final step):
        updateState(ProfileState.error(msg, newProfile, currentStep: step));
      default:
        updateState(ProfileState.loaded(newProfile));
    }
  }

  // ── Onboarding Actions ──

  Future<String?> completeCurrentStep() async {
    if (state is ProfileStateSaving) return null;

    final currentProfile = state.profile;
    if (currentProfile == null) return null;
    final currentStep = state.currentStep;

    // 1. Logic for specific steps if needed
    if (currentStep == 1) {
      // Final step
      final success = await completeOnboarding();
      return success ? RoutePaths.dashboard : null;
    }

    // 2. Intermediate steps
    updateState(ProfileState.saving(currentProfile, currentStep: currentStep));

    try {
      final nextStep = currentStep + 1;
      await _savePartialProgress(nextStep);
      updateState(ProfileState.loaded(currentProfile, currentStep: nextStep));
      return OnboardingFlowMixin.stepRoutes[nextStep] ?? RoutePaths.dashboard;
    } finally {
      // If error occurred or completed successfully, the state is updated
    }
  }

  Future<void> _savePartialProgress(int step) async {
    final currentUid = _authRepository.currentUser?.uid;
    if (currentUid == null) return;

    final profileEntity = state.profile?.copyWith(
          uid: currentUid,
          currentStep: step,
          isOnboardingComplete: false,
          updatedAt: DateTime.now().toIso8601String(),
        ) ??
        const UserEntity();

    await _profileRepository.saveProfile(profileEntity);
  }

  Future<bool> completeOnboarding() async {
    if (state is ProfileStateSaving) return false;

    final currentProfile = state.profile;
    if (currentProfile == null) return false;
    final currentStep = state.currentStep;

    updateState(ProfileState.saving(currentProfile, currentStep: currentStep));

    final currentUid = _authRepository.currentUser?.uid;
    AppLogger.i('completeOnboarding: uid=$currentUid');

    if (currentUid == null) {
      updateState(ProfileState.error(
          'Not signed in — cannot save profile.', currentProfile,
          currentStep: currentStep));
      AppLogger.e('completeOnboarding: no authenticated user found');
      return false;
    }

    final profileEntity = currentProfile.copyWith(
      uid: currentUid,
      currentStep: currentStep,
      isOnboardingComplete: true,
      updatedAt: DateTime.now().toIso8601String(),
    );

    final result = await _profileRepository.saveProfile(profileEntity);

    return result.fold(
      (failure) {
        updateState(ProfileState.error(failure.message, profileEntity,
            currentStep: currentStep));
        AppLogger.e('completeOnboarding save failed: ${failure.message}');
        return false;
      },
      (_) {
        updateState(
            ProfileState.loaded(profileEntity, currentStep: currentStep));
        AppLogger.i('completeOnboarding: profile saved OK (uid=$currentUid)');
        return true;
      },
    );
  }

  // ── SessionLifecycleHandler ──

  @override
  Future<void> onSessionStarted(String userId) async {
    AppLogger.i('ProfileController: session started for $userId');
    await _loadProfile();
  }

  @override
  Future<void> onSessionEnded() async {
    AppLogger.i('ProfileController: session ended, resetting state');
    updateState(const ProfileState.initial());
  }

  @override
  Future<void> onAccountDeleted(String userId) async {
    await onSessionEnded();
  }
}

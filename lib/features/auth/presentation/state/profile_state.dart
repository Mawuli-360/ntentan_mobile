import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ntentan/features/auth/domain/entities/user_entity.dart';

part 'profile_state.freezed.dart';

@freezed
sealed class ProfileState with _$ProfileState {
  const ProfileState._();

  const factory ProfileState.initial() = ProfileStateInitial;

  const factory ProfileState.loading() = ProfileStateLoading;

  const factory ProfileState.loaded(
    UserEntity profile, {
    @Default(0) int currentStep,
  }) = ProfileStateLoaded;

  const factory ProfileState.saving(
    UserEntity profile, {
    @Default(0) int currentStep,
  }) = ProfileStateSaving;

  const factory ProfileState.error(
    String message,
    UserEntity profile, {
    @Default(0) int currentStep,
  }) = ProfileStateError;

  UserEntity? get profile => switch (this) {
        ProfileStateLoaded(profile: final p) => p,
        ProfileStateSaving(profile: final p) => p,
        ProfileStateError(profile: final p) => p,
        _ => null,
      };

  int get currentStep => switch (this) {
        ProfileStateLoaded(currentStep: final s) => s,
        ProfileStateSaving(currentStep: final s) => s,
        ProfileStateError(currentStep: final s) => s,
        _ => 0,
      };

  bool get isSaving => switch (this) {
        ProfileStateSaving() => true,
        _ => false,
      };

  String? get saveError => switch (this) {
        ProfileStateError(message: final m) => m,
        _ => null,
      };

  bool get isOnboardingComplete => currentStep >= 1;

  bool get isHealthProfileValid {
    final currentProfile = profile;
    if (currentProfile == null) return false;

    final hasContact = currentProfile.emergencyConfig.contacts.isNotEmpty;
    final firstContact =
        hasContact ? currentProfile.emergencyConfig.contacts.first : null;

    return currentProfile.userName.trim().isNotEmpty &&
        firstContact != null &&
        firstContact.name.trim().isNotEmpty &&
        firstContact.phoneNumber.trim().isNotEmpty;
  }
}

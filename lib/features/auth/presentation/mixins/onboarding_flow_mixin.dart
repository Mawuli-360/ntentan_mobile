import 'package:flutter/material.dart';
import 'package:ntentan/core/app_route/route_paths.dart';
import 'package:ntentan/features/auth/presentation/state/profile_state.dart';

mixin OnboardingFlowMixin on ChangeNotifier {
  ProfileState get state;
  void updateState(ProfileState newState);

  static const Map<int, String> stepRoutes = {
    0: RoutePaths.profileRegistration,
    1: RoutePaths.languagePreference,
  };

  String getInitialRoute() {
    final profile = state.profile;
    if (profile == null) return stepRoutes[0]!;
    if (profile.isOnboardingComplete) return RoutePaths.dashboard;

    return stepRoutes[state.currentStep] ?? stepRoutes[0]!;
  }

  String? goToPreviousStep() {
    final currentStep = state.currentStep;
    if (currentStep > 0) {
      final newStep = currentStep - 1;
      _setStep(newStep);
      return stepRoutes[newStep] ?? stepRoutes[0]!;
    }
    return null;
  }

  void goToStep(int step) {
    _setStep(step);
  }

  void _setStep(int step) {
    switch (state) {
      case ProfileStateLoaded(profile: final p):
        updateState(ProfileState.loaded(p, currentStep: step));
      case ProfileStateSaving(profile: final p):
        updateState(ProfileState.saving(p, currentStep: step));
      case ProfileStateError(message: final m, profile: final p):
        updateState(ProfileState.error(m, p, currentStep: step));
      default:
        break;
    }
  }
}

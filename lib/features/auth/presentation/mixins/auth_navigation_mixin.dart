import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ntentan/core/extension/context.dart';
import 'package:ntentan/app/injection_container.dart';
import 'package:ntentan/features/auth/domain/repositories/profile_repository.dart';
import 'package:ntentan/features/auth/presentation/controllers/auth_controller.dart';
import 'package:ntentan/features/auth/presentation/controllers/profile_controller.dart';

mixin AuthNavigationMixin<T extends StatefulWidget> on State<T> {
  Future<void> fetchUserDataAndNavigate(
    BuildContext context,
    AuthController authController,
  ) async {
    final profileRepository = sl<ProfileRepository>();
    final onboardingController = sl<ProfileController>();

    final currentUser = authController.currentUser;
    if (currentUser == null) {
      if (context.mounted) {
        context.hideLoadingModal();
        context.showErrorSnackBar('Authentication error: User is null');
      }
      return;
    }

    final result = await profileRepository.fetchProfileFromRemote(currentUser.uid);

    if (!context.mounted) return;
    context.hideLoadingModal();

    result.fold(
      (_) => context.go(onboardingController.getInitialRoute()),
      (profile) => context.go(onboardingController.getInitialRoute()),
    );
  }
}

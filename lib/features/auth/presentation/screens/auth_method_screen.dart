import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ntentan/core/app_route/route_paths.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:ntentan/core/constants/app_images.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/core/constants/logger.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/theme/app_theme.dart';
import 'package:ntentan/core/constants/haptics.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:ntentan/features/auth/presentation/controllers/auth_controller.dart';
import 'package:provider/provider.dart';
import 'package:ntentan/features/auth/presentation/widgets/auth_welcome_section.dart';
import 'package:ntentan/features/auth/presentation/widgets/auth_modern_button.dart';
import 'package:ntentan/core/extension/context.dart';
import 'package:ntentan/app/injection_container.dart';
import 'package:ntentan/features/auth/domain/repositories/profile_repository.dart';
import 'package:ntentan/features/auth/presentation/controllers/profile_controller.dart';

class AuthMethodScreen extends StatelessWidget {
  const AuthMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();

    return Scaffold(
      backgroundColor: AppTheme.dark.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.space24),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Illustration
              Center(
                child: Image(
                  image: AppImages.authBg,
                  height: 200,
                  width: 200,
                ),
              ).animate().fade(duration: 800.ms).scale(delay: 200.ms),

              const SizedBox(height: AppSizes.space32),

              // Supportive Wording
              const AuthWelcomeSection(),

              const Spacer(flex: 3),

              //  Email
              AuthModernButton(
                icon: Iconsax.sms,
                label: 'Continue with Email',
                onPressed: () {
                  AppHaptics.success();
                  context.push(RoutePaths.login);
                },
                backgroundColor: AppColors.vi,
                textColor: Colors.black,
              ).animate().fadeIn(delay: 800.ms),

              const SizedBox(height: AppSizes.space20),

              // Google
              AuthModernButton(
                icon: AppImages.google,
                label: 'Continue with Google',
                onPressed: () async {
                  AppHaptics.tap();
                  context.showLoadingModal('Signing in with Google...');

                  final success = await authController.signInWithGoogle();

                  if (success) {
                    final profileRepository = sl<ProfileRepository>();
                    final onboardingController = sl<ProfileController>();

                    final currentUser = authController.currentUser;
                    if (currentUser == null) {
                      if (context.mounted) {
                        context.hideLoadingModal();
                        context.showErrorSnackBar(
                            'Authentication error: User is null');
                      }
                      return;
                    }

                    final result = await profileRepository
                        .fetchProfileFromRemote(currentUser.uid);

                    if (context.mounted) {
                      context.hideLoadingModal();
                      result.fold(
                        (_) => context
                            .go(onboardingController.getInitialRoute()),
                        (profile) => context
                            .go(onboardingController.getInitialRoute()),
                      );
                    }
                  } else {
                    if (context.mounted) {
                      context.hideLoadingModal();
                      if (authController.state.errorMessage != null) {
                        AppLogger.e(authController.state.errorMessage!);
                        context.showErrorSnackBar(authController.state.errorMessage!);
                      }
                    }
                  }
                },
                backgroundColor: Colors.white,
                textColor: Colors.black,
              ).animate().fadeIn(delay: 1000.ms),

              const SizedBox(height: AppSizes.space48),
            ],
          ),
        ),
      ),
    );
  }
}

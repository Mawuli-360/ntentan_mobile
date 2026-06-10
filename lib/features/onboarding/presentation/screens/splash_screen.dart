import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ntentan/core/app_route/route_paths.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/core/constants/app_images.dart';
import 'package:ntentan/app/injection_container.dart';
import 'package:ntentan/features/auth/domain/repositories/auth_repository.dart';
import 'package:ntentan/features/auth/domain/repositories/profile_repository.dart';
import 'package:ntentan/features/auth/presentation/controllers/profile_controller.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ntentan/core/utils/storage/shared_prefs_storage.dart';
import 'package:ntentan/core/services/session_lifecycle_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _autoNavigateTimer;

  @override
  void initState() {
    super.initState();
    _autoNavigateTimer = Timer(
      const Duration(milliseconds: 3000),
      _navigateToOnboarding,
    );
  }

  @override
  void dispose() {
    _autoNavigateTimer?.cancel();
    super.dispose();
  }

  void _navigateToOnboarding() async {
    final sharedPrefs = sl<SharedPrefsStorage>();

    // 1. Check if terms are accepted
    if (!sharedPrefs.isTermsAccepted()) {
      if (mounted) context.go(RoutePaths.termsAcceptance);
      return;
    }

    // 2. Check if signed in
    final authRepository = sl<AuthRepository>();
    final user = authRepository.currentUser;

    if (user == null) {
      if (mounted) context.go(RoutePaths.authMethod);
      return;
    }

    // --- RESTORE SESSION FOR EXISTING USER ---
    await sl<SessionLifecycleService>().startSession(user.uid);

    // 3. Check profile completion via ProfileController
    final profileRepository = sl<ProfileRepository>();
    final onboardingController = sl<ProfileController>();
    final result = await profileRepository.getProfile();

    if (mounted) {
      result.fold(
        (_) => context.go(onboardingController.getInitialRoute()),
        (profile) {
          context.go(onboardingController.getInitialRoute());
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Semantics(
        label: 'Ntentan. Your accessible health companion.',
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 3),

              // Professional Logo Integration: Grow from nothing (0.0 scale)
              _buildLogo()
                  .animate()
                  .fadeIn(duration: 400.ms)
                  .rotate(
                    begin: 2.0, // Two full turns
                    end: 0,
                    duration: 1800.ms,
                    curve: Curves.elasticOut,
                  )
                  .scale(
                    begin: Offset.zero,
                    end: const Offset(1, 1),
                    duration: 1400.ms,
                    curve: Curves.elasticOut,
                  ),

              const SizedBox(height: AppSizes.space32),

              // Stylish Brand Typography
              Text(
                'Ntentan',
                style: TextStyle(
                  fontFamily: 'LexendDeca',
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.0,
                ),
              )
                  .animate()
                  .fadeIn(delay: 400.ms, duration: 800.ms)
                  .slideY(begin: 0.3, end: 0, curve: Curves.easeOutCubic)
                  .blur(begin: const Offset(10, 10), end: Offset.zero),

              const SizedBox(height: 8),

              // Supportive Subtitle
              Text(
                'Accessibility-First Healthcare',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                      letterSpacing: 0.5,
                    ),
              ).animate().fadeIn(delay: 800.ms, duration: 800.ms),

              const Spacer(flex: 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return SizedBox(
      width: 300,
      height: 300,
      child: Image(
        image: AppImages.ntentan,
        fit: BoxFit.contain,
      ),
    );
  }
}

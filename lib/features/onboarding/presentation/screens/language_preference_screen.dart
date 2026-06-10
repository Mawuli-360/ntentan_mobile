import 'package:ntentan/features/auth/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:ntentan/core/extension/context.dart';
import 'package:ntentan/core/utils/app_loader_anim.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/core/constants/haptics.dart';
import 'package:ntentan/features/auth/presentation/controllers/profile_controller.dart';

import 'package:ntentan/features/onboarding/presentation/widgets/language_section_label.dart';
import 'package:ntentan/features/onboarding/presentation/widgets/spoken_language_selector.dart';
import 'package:ntentan/core/widgets/app_header.dart';

class LanguagePreferenceScreen extends StatelessWidget {
  const LanguagePreferenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProfileController>();

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppHeader(
        title: 'Language & Communication',
        onBackPressed: () {
          AppHaptics.tap();
          final route = controller.goToPreviousStep();
          if (route != null) context.go(route);
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.space24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Semantics(
                header: true,
                child: Text(
                  'How do you communicate?',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
              const SizedBox(height: AppSizes.space8),
              const Text(
                'Choose your preferred languages and how you want the app to respond.',
                style: TextStyle(color: AppColors.textSecondary),
              ),

              const SizedBox(height: AppSizes.space32),

              // ── Spoken Language ──
              const LanguageSectionLabel(text: 'Spoken Language'),
              const SizedBox(height: AppSizes.space12),
              SpokenLanguageSelector(
                languages: const ['English', 'Twi'],
                selectedLanguage:
                    (controller.state.profile?.selectedLanguage ?? "English"),
                onLanguageSelected: (lang) => controller.updateProfile(
                    (controller.state.profile ?? const UserEntity())
                        .copyWith(selectedLanguage: lang)),
              ),

              const SizedBox(height: AppSizes.space32),

              const SizedBox(height: AppSizes.space40),

              // Get started button
              SizedBox(
                width: double.infinity,
                height: AppSizes.minTouchTarget,
                child: ElevatedButton(
                  onPressed: controller.state.isSaving
                      ? null
                      : () async {
                          AppHaptics.success();
                          final nextRoute =
                              await controller.completeCurrentStep();
                          if (nextRoute != null && context.mounted) {
                            context.go(nextRoute);
                          } else if (context.mounted) {
                            context.showErrorSnackBar(controller
                                    .state.saveError ??
                                'Failed to save profile. Please try again.');
                          }
                        },
                  child: controller.state.isSaving
                      ? AppLoaderAnim.spinKitCircle(25, color: AppColors.vi)
                      : const Text('Get Started'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

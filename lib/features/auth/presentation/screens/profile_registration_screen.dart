import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/features/auth/presentation/controllers/profile_controller.dart';
import 'package:ntentan/core/widgets/app_header.dart';

import 'package:ntentan/features/auth/domain/entities/user_entity.dart';
import 'package:ntentan/features/auth/presentation/widgets/emergency_contact_section.dart';
import 'package:ntentan/features/auth/presentation/widgets/profile_name_input.dart';
import 'package:ntentan/features/auth/presentation/widgets/profile_submit_button.dart';

/// Minimal data collection: name and one emergency contact.
/// Progressive onboarding — rest collected later via dashboard nudges.
class ProfileRegistrationScreen extends StatelessWidget {
  const ProfileRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProfileController>();
    final profile = controller.state.profile ?? const UserEntity();
    final contacts = profile.emergencyConfig.contacts;
    final primaryContact = contacts.isNotEmpty ? contacts.first : null;
    final emergencyName = primaryContact?.name ?? '';
    final emergencyPhone = primaryContact?.phoneNumber ?? '';
    final emergencyRelationship = primaryContact?.relationship ?? '';

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: const AppHeader(
        title: 'Profile Registration',
        showBackButton: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.space24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Intro text
              Semantics(
                header: true,
                child: Text(
                  'Basic User Info',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
              const SizedBox(height: AppSizes.space8),
              Text(
                'We only need a few details now. You can add more later from your profile.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),

              const SizedBox(height: AppSizes.space32),

              // Name field
              ProfileNameInput(
                initialValue: profile.userName,
                onChanged: (name) =>
                    controller.updateProfile(profile.copyWith(userName: name)),
              ),

              const SizedBox(height: AppSizes.space24),

              // Emergency contact section
              EmergencyContactSection(
                initialName: emergencyName,
                initialPhone: emergencyPhone,
                initialRelationship: emergencyRelationship,
                onChanged: (name, phone, relationship) =>
                    controller.updateProfile(
                  profile.copyWith(
                    emergencyConfig: profile.emergencyConfig.copyWith(
                      contacts: [
                        EmergencyContact(
                          name: name,
                          phoneNumber: phone,
                          relationship: relationship,
                        )
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppSizes.space32),

              // Continue button
              ProfileSubmitButton(
                isValid: controller.state.isHealthProfileValid,
                isSaving: controller.state.isSaving,
                onPressed: () async {
                  final nextRoute = await controller.completeCurrentStep();
                  if (nextRoute != null && context.mounted) {
                    context.go(nextRoute);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

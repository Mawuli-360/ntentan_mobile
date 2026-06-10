import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/core/widgets/app_header.dart';

import 'package:ntentan/features/settings/presentation/widgets/trust_pillar_card.dart';

/// Privacy & Terms Screen
/// High-contrast, accessibility-first screen explaining data trust pillars.
class PrivacyTermsScreen extends StatelessWidget {
  const PrivacyTermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: const AppHeader(
        title: 'Privacy & Data Trust',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.space24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your privacy is our priority. We designed Ntentan to be the safest place for your health data.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: AppSizes.space32),
            const TrustPillarCard(
              icon: Iconsax.location_add,
              title: 'SOS shares your location',
              content:
                  'Only when you press SOS: your location and medical summary go to your chosen emergency contacts. You configure this.',
              color: AppColors.emergency,
            ),
            const TrustPillarCard(
              icon: Iconsax.shield_search,
              title: 'Only on SOS, No selling. No ads.',
              content:
                  'We do not sell your data to anyone. No advertisers. No insurance companies. Ever.',
              color: AppColors.vi,
              isWarning: true,
              warningChar: '!',
            ),
            const TrustPillarCard(
              icon: Iconsax.lock,
              title: 'We never sell, Health data stays private',
              content:
                  'Your medical records, medications, and appointments are only visible to you and people you choose.',
              color: AppColors.vi,
              isWarning: true,
              warningChar: '✗',
            ),
            const TrustPillarCard(
              icon: Iconsax.trash,
              title: 'Your data, your rules',
              content:
                  'Delete everything in one tap from Settings. We keep nothing after deletion.',
              color: AppColors.shared,
              isWarning: true,
              warningChar: '✓',
            ),
            const SizedBox(height: AppSizes.space40),
            Center(
              child: Text(
                'Last updated: February 2026',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.textMuted,
                    ),
              ),
            ),
            const SizedBox(height: AppSizes.space64),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ntentan/core/app_route/route_paths.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';

import 'package:ntentan/features/auth/presentation/widgets/privacy_pillar.dart';
import 'package:ntentan/app/injection_container.dart';
import 'package:ntentan/core/utils/storage/shared_prefs_storage.dart';

/// Terms Acceptance Screen
/// Mandatory gate before authentication.
class TermsAcceptanceScreen extends StatefulWidget {
  const TermsAcceptanceScreen({super.key});

  @override
  State<TermsAcceptanceScreen> createState() => _TermsAcceptanceScreenState();
}

class _TermsAcceptanceScreenState extends State<TermsAcceptanceScreen> {
  bool _accepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.space24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSizes.space32),
              Text(
                'Safety & Privacy First',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: AppSizes.space8),
              Text(
                'Please review and accept our core privacy pillars to continue.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
              const SizedBox(height: AppSizes.space32),
              Expanded(
                child: SingleChildScrollView(
                  child: const Column(
                    children: [
                      PrivacyPillar(
                        icon: Iconsax.location_add,
                        title: 'SOS Transparency',
                        desc: 'Location only shared when SOS is active.',
                        color: AppColors.emergency,
                      ),
                      PrivacyPillar(
                        icon: Iconsax.shield_search,
                        title: 'No Ads, No Selling',
                        desc: 'We never sell your data to anyone. Ever.',
                        color: AppColors.vi,
                      ),
                      PrivacyPillar(
                        icon: Iconsax.lock,
                        title: 'Health Data Privacy',
                        desc: 'Records are encrypted and privately stored.',
                        color: AppColors.vi,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.space24),
              Row(
                children: [
                  Checkbox(
                    value: _accepted,
                    onChanged: (v) => setState(() => _accepted = v ?? false),
                    activeColor: AppColors.vi,
                    side:
                        const BorderSide(color: AppColors.textOnDark, width: 2),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _accepted = !_accepted),
                      child: Text(
                        'I agree to the Terms of Service and Privacy Policy',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textPrimary,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.space24),
              ElevatedButton(
                onPressed: _accepted
                    ? () async {
                        await sl<SharedPrefsStorage>().setTermsAccepted(true);
                        if (context.mounted) context.push(RoutePaths.authMethod);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.vi,
                  disabledBackgroundColor: AppColors.surface2,
                ),
                child: const Text('Accept & Continue'),
              ),
              const SizedBox(height: AppSizes.space16),
            ],
          ),
        ),
      ),
    );
  }
}

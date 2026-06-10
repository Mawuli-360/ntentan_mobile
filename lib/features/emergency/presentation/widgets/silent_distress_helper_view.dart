import 'package:flutter/material.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/features/emergency/presentation/widgets/helper_card.dart';
import 'package:ntentan/features/emergency/presentation/widgets/silent_distress_language_selector.dart';

class SilentDistressHelperView extends StatelessWidget {
  final Map<String, String> helperTexts;
  final String selectedLanguage;
  final ValueChanged<String> onLanguageSelected;
  final VoidCallback onBack;

  const SilentDistressHelperView({
    super.key,
    required this.helperTexts,
    required this.selectedLanguage,
    required this.onLanguageSelected,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Language selector
        SilentDistressLanguageSelector(
          languages: helperTexts,
          selectedLanguage: selectedLanguage,
          onLanguageSelected: onLanguageSelected,
        ),
        const SizedBox(height: AppSizes.space24),

        // Helper card — show to bystander
        Expanded(
          child: HelperCard(helperText: helperTexts[selectedLanguage] ?? ''),
        ),
        const SizedBox(height: AppSizes.space16),

        SizedBox(
          width: double.infinity,
          height: AppSizes.minTouchTarget,
          child: OutlinedButton(
            onPressed: onBack,
            child: const Text('Back to silent mode'),
          ),
        ),
      ],
    );
  }
}

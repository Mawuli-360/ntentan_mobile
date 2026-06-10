import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/core/constants/haptics.dart';

class SpokenLanguageSelector extends StatelessWidget {
  final List<String> languages;
  final String selectedLanguage;
  final ValueChanged<String> onLanguageSelected;

  const SpokenLanguageSelector({
    super.key,
    required this.languages,
    required this.selectedLanguage,
    required this.onLanguageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSizes.space8,
      runSpacing: AppSizes.space8,
      children: languages.map((lang) {
        final isSelected = selectedLanguage == lang;
        return ChoiceChip(
          label: Text(lang),
          selected: isSelected,
          onSelected: (_) {
            AppHaptics.tap();
            onLanguageSelected(lang);
          },
          selectedColor: AppColors.vi.withValues(alpha: 0.1),
          checkmarkColor: AppColors.vi,
          side: BorderSide(
            color: isSelected ? AppColors.vi : AppColors.border,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.space12,
            vertical: AppSizes.space8,
          ),
        );
      }).toList(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';

class SilentDistressLanguageSelector extends StatelessWidget {
  final Map<String, String> languages;
  final String selectedLanguage;
  final ValueChanged<String> onLanguageSelected;

  const SilentDistressLanguageSelector({
    super.key,
    required this.languages,
    required this.selectedLanguage,
    required this.onLanguageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: languages.keys.map((l) {
          final active = l == selectedLanguage;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(l),
              selected: active,
              onSelected: (_) => onLanguageSelected(l),
              selectedColor: AppColors.vi.withValues(alpha: 0.1),
              checkmarkColor: AppColors.vi,
              side: BorderSide(
                  color: active ? AppColors.vi : AppColors.border),
            ),
          );
        }).toList(),
      ),
    );
  }
}

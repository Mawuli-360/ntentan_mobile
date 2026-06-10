import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';

class LanguageSectionLabel extends StatelessWidget {
  final String text;

  const LanguageSectionLabel({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            letterSpacing: 2,
            color: AppColors.textMuted,
            fontWeight: FontWeight.w600,
          ),
    );
  }
}

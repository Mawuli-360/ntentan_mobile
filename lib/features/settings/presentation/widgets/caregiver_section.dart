import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';

class CaregiverSection extends StatelessWidget {
  final String label;
  final String? subtitle;
  final Widget child;
  final double spacing;

  const CaregiverSection({
    super.key,
    required this.label,
    this.subtitle,
    required this.child,
    this.spacing = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 6),
          Text(
            subtitle!,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
        SizedBox(height: spacing),
        child,
      ],
    );
  }
}

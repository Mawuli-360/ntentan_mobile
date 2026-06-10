import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';

/// Small pill-shaped tag with icon + label.
/// Color is always paired with text — never color alone (WCAG 1.4.1).
class FeatureTag extends StatelessWidget {
  final String label;
  final TrackType type;

  const FeatureTag({
    super.key,
    required this.label,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppColors.trackColor(type);
    final bgColor = AppColors.trackBg(type);
    final borderColor = AppColors.trackBorder(type);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

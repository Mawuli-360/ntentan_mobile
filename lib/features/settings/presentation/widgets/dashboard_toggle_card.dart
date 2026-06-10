import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';

class DashboardToggleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool value;
  final Function(bool) onChanged;
  final bool isCritical;

  const DashboardToggleCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.onChanged,
    this.isCritical = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        border: Border.all(
            color: isCritical
                ? AppColors.emergency.withValues(alpha: 0.3)
                : AppColors.border),
      ),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        secondary:
            Icon(icon, color: isCritical ? AppColors.emergency : AppColors.vi),
        title: Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle,
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
        activeColor: isCritical ? AppColors.emergency : AppColors.vi,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: AppSizes.space12),
      ),
    );
  }
}

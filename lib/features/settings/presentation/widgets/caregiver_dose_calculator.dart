import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';

class CaregiverDoseCalculator extends StatelessWidget {
  final String totalDailyDose;

  const CaregiverDoseCalculator({
    super.key,
    required this.totalDailyDose,
  });

  @override
  Widget build(BuildContext context) {
    if (totalDailyDose.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.vi.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        border: Border.all(color: AppColors.vi.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Icon(Iconsax.calculator, size: 16, color: AppColors.vi),
          const SizedBox(width: 8),
          Text(
            'Total daily dose: $totalDailyDose',
            style: const TextStyle(
              color: AppColors.vi,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

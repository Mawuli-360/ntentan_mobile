import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';

class HelperCard extends StatelessWidget {
  final String helperText;

  const HelperCard({
    super.key,
    required this.helperText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.space32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusXL),
        border: Border.all(color: AppColors.emergency, width: 3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🆘', style: TextStyle(fontSize: 64)),
          const SizedBox(height: AppSizes.space24),
          Text(
            helperText,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.w600,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.space24),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.emergency.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'EMERGENCY — PLEASE HELP',
              style: TextStyle(
                color: AppColors.emergency,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

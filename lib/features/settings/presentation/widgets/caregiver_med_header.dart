import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ntentan/core/theme/app_colors.dart';

class CaregiverMedHeader extends StatelessWidget {
  const CaregiverMedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CAREGIVER ASSISTANT',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.vi,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w800,
              ),
        ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0),
      ],
    );
  }
}

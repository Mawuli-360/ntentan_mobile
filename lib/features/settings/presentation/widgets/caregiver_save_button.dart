import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';

class CaregiverSaveButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const CaregiverSaveButton({
    super.key,
    required this.onPressed,
    this.label = 'Confirm Schedule',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        gradient: LinearGradient(
          colors: [
            AppColors.vi,
            AppColors.vi.withValues(alpha: 0.8),
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(delay: 400.ms)
        .slideY(begin: 0.2, end: 0);
  }
}

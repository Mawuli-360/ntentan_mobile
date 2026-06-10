import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/core/constants/haptics.dart';
import 'package:ntentan/core/utils/app_loader_anim.dart';

class ProfileSubmitButton extends StatelessWidget {
  final bool isValid;
  final bool isSaving;
  final VoidCallback onPressed;

  const ProfileSubmitButton({
    super.key,
    required this.isValid,
    required this.isSaving,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.minTouchTarget,
      child: ElevatedButton(
        onPressed: (isValid && !isSaving)
            ? () {
                AppHaptics.success();
                onPressed();
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: isValid ? AppColors.vi : AppColors.surface2,
          foregroundColor: isValid ? AppColors.bg : AppColors.textMuted,
        ),
        child: isSaving
            ? AppLoaderAnim.spinKitCircle(25)
            : const Text('Continue'),
      ),
    );
  }
}

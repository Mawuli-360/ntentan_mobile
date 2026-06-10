import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/utils/app_loader_anim.dart';

class AuthModernButton extends StatelessWidget {
  final Object icon;
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final String? iconPath;
  final bool isLoading;

  const AuthModernButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
    this.iconPath,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isGoogle = label.contains('Google');

    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        border: borderColor != null ? Border.all(color: borderColor!) : null,
        boxShadow: backgroundColor == AppColors.vi
            ? [
                BoxShadow(
                  color: AppColors.vi.withValues(alpha: 0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: isLoading
                ? AppLoaderAnim.spinkitFadingCircle(20)
                : Row(
                    children: [
                      if (isGoogle)
                        SvgPicture.asset(icon as String, height: 24, width: 24)
                      else
                        Icon(icon as IconData, color: textColor, size: 24),
                      Expanded(
                        child: Center(
                          child: Text(
                            label,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

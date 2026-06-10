import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';

class SettingsItem extends StatelessWidget {
  final IconData? icon;
  final String? label;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? iconColor;
  final bool disableRipple;
  final Widget?
      customChild; // Allow passing a custom layout instead of label/subtitle

  const SettingsItem({
    super.key,
    this.icon,
    this.label,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.iconColor,
    this.disableRipple = false,
    this.customChild,
  }) : assert(label != null || customChild != null,
            'Must provide either label or customChild');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.space12),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        child: InkWell(
          onTap: onTap,
          splashColor: disableRipple ? Colors.transparent : null,
          highlightColor: disableRipple ? Colors.transparent : null,
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          child: Container(
            padding: const EdgeInsets.all(AppSizes.space16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderLight),
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            ),
            child: Row(
              children: [
                if (icon != null) ...[
                  Container(
                    padding: const EdgeInsets.all(AppSizes.space8),
                    decoration: BoxDecoration(
                      color: (iconColor ?? Colors.white).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                    ),
                    child:
                        Icon(icon, color: iconColor ?? Colors.white, size: 24),
                  ),
                  const SizedBox(width: AppSizes.space16),
                ],
                Expanded(
                  child: customChild ??
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label!,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                          ),
                          if (subtitle != null) ...[
                            const SizedBox(height: 2),
                            Text(
                              subtitle!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.7),
                                    fontSize: 12,
                                  ),
                            ),
                          ],
                        ],
                      ),
                ),
                trailing ??
                    const Icon(Icons.arrow_forward_ios_rounded,
                        color: Colors.white38, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

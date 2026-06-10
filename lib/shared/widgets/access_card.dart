import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';

/// A high-contrast card with a colored 3px top accent bar.
/// Used across all features. Hard edges, solid backgrounds — no blur.
/// Color is always paired with icon/label — never standalone.
class AccessCard extends StatelessWidget {
  final TrackType? trackType;
  final String? title;
  final String? icon;
  final String? description;
  final Widget? child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final bool selected;

  const AccessCard({
    super.key,
    this.trackType,
    this.title,
    this.icon,
    this.description,
    this.child,
    this.onTap,
    this.padding,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = trackType != null ? AppColors.trackColor(trackType!) : null;
    final bgColor = selected && trackType != null
        ? AppColors.trackBg(trackType!)
        : AppColors.surface;
    final borderColor = selected && trackType != null
        ? AppColors.trackBorder(trackType!)
        : AppColors.border;

    return Semantics(
      button: onTap != null,
      selected: selected,
      label: title,
      child: Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Colored top accent bar
                if (color != null)
                  Container(
                    height: 3,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(AppSizes.radiusLarge),
                        topRight: Radius.circular(AppSizes.radiusLarge),
                      ),
                    ),
                  ),

                Padding(
                  padding: padding ?? const EdgeInsets.all(AppSizes.space20),
                  child: child ??
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (icon != null)
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: AppSizes.space8),
                              child: Text(
                                icon!,
                                style: const TextStyle(fontSize: 28),
                              ),
                            ),
                          if (title != null)
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: AppSizes.space4),
                              child: Text(
                                title!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                            ),
                          if (description != null)
                            Text(
                              description!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppColors.textSecondary,
                                    height: 1.7,
                                  ),
                            ),
                        ],
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

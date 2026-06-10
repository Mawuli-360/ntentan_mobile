import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/core/widgets/accessible_widget.dart';
import 'package:ntentan/app/injection_container.dart';
import 'package:ntentan/core/services/accessibility/haptic_service.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final String routePath;
  final Color color;
  final Object icon;
  final VoidCallback? onTapOverride;

  const FeatureCard({
    super.key,
    required this.title,
    required this.description,
    required this.routePath,
    required this.color,
    required this.icon,
    this.onTapOverride,
  });

  @override
  Widget build(BuildContext context) {
    return AccessibleWidget(
      label: '$title. $description',
      hint: 'Double tap to open $title',
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
          color: AppColors.surface,
          border: Border.all(color: color.withValues(alpha: 0.6), width: 1.5),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
          child: InkWell(
            onTap: () {
              sl<HapticService>().tapFeedback();
              if (onTapOverride != null) {
                onTapOverride!();
              } else {
                context.push(routePath);
              }
            },
            borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.space16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      borderRadius:
                          BorderRadius.circular(AppSizes.radiusMedium),
                      border: Border.all(color: color.withValues(alpha: 0.3)),
                    ),
                    child: Center(
                      child: icon is IconData
                          ? Icon(icon as IconData, size: 24, color: color)
                          : icon is String
                              ? Text(icon as String,
                                  style: const TextStyle(fontSize: 24))
                              : Image(
                                  image: icon as ImageProvider,
                                  width: 28,
                                  height: 28,
                                  color: color,
                                ),
                    ),
                  ),
                  const SizedBox(height: AppSizes.space32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontWeight: FontWeight.w500,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

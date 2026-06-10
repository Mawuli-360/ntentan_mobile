import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/core/constants/app_images.dart';

class DashboardHeader extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;

  const DashboardHeader({
    super.key,
    this.title,
    this.titleWidget,
  }) : assert(title != null || titleWidget != null,
            'Provide either title or titleWidget');

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: titleWidget ??
              Semantics(
                header: true,
                child: Text(
                  title!,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                ),
              ),
        ),
        Container(
          padding: const EdgeInsets.all(AppSizes.space8),
          decoration: BoxDecoration(
            color: AppColors.vi.withValues(alpha: 0.1),
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.vi.withValues(alpha: 0.2),
            ),
          ),
          child: Image(
            image: AppImages.blind,
            width: 32,
            height: 32,
            color: AppColors.vi,
          ),
        ).animate().scale(
              delay: 200.ms,
              duration: 400.ms,
              curve: Curves.easeOutBack,
            ),
      ],
    );
  }
}

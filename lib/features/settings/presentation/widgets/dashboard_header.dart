import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';

class DashboardHeader extends StatelessWidget {
  final String title;

  const DashboardHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: AppColors.textSecondary,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w700,
          ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/features/dashboard/presentation/widgets/dashboard_header.dart';

class DashboardGreeting extends StatelessWidget {
  final String userName;
  const DashboardGreeting({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return DashboardHeader(
      titleWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            header: true,
            child: Text(
              'Welcome to',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ),
          Text(
            'Ntentan Assistant',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ],
      ),
    );
  }
}

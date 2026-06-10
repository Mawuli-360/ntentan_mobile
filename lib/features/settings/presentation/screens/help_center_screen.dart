import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/core/widgets/app_header.dart';

import 'package:ntentan/features/settings/presentation/widgets/dashboard_header.dart';
import 'package:ntentan/features/settings/presentation/widgets/dashboard_help_tile.dart';
import 'package:ntentan/features/settings/presentation/widgets/dashboard_contact_card.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: const AppHeader(
        title: 'Help Center',
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.space20),
        children: [
          const DashboardHeader(title: 'Getting Started'),
          const SizedBox(height: AppSizes.space16),
          DashboardHelpTile(
            title: 'Ntentan Basics',
            subtitle: 'Learn how to navigate your dashboard',
            icon: Icons.explore_rounded,
          ),
          const SizedBox(height: AppSizes.space12),
          DashboardHelpTile(
            title: 'Using Voice Assistant',
            subtitle: 'Voice gesture commands and audio feedback',
            icon: Icons.record_voice_over_rounded,
          ),
          const SizedBox(height: AppSizes.space32),
          const DashboardHeader(title: 'Support Channels'),
          const SizedBox(height: AppSizes.space16),
          Row(
            children: [
              Expanded(
                child: DashboardContactCard(
                  label: 'Call Support',
                  icon: Icons.phone_outlined,
                  color: AppColors.vi,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: const DashboardContactCard(
                  label: 'Email Us',
                  icon: Icons.email_outlined,
                  color: AppColors.ai,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

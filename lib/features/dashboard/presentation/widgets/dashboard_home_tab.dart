import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/features/auth/presentation/controllers/profile_controller.dart';
import 'package:ntentan/features/dashboard/presentation/widgets/upcoming_medication_card.dart';
import 'package:ntentan/features/dashboard/presentation/widgets/dashboard_greeting.dart';
import 'package:ntentan/shared/widgets/settings_section_header.dart';
import 'package:ntentan/features/dashboard/presentation/widgets/quick_actions_grid.dart';

class DashboardHomeTab extends StatelessWidget {
  const DashboardHomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = context.watch<ProfileController>();

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: AppSizes.space16,
              right: AppSizes.space16,
              top: AppSizes.space16,
              bottom: AppSizes.space8,
            ),
            child: DashboardGreeting(
              userName: profileController.state.profile?.userName ?? "",
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: AppSizes.space16,
                right: AppSizes.space16,
                top: AppSizes.space16,
                bottom:
                    120, // Extra padding for the floating camera reader button
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SettingsSectionHeader(title: 'QUICK ACTIONS'),

                  // Cleaned grid rendering extracted to separate widget
                  const QuickActionsGrid(),

                  const SizedBox(height: AppSizes.space32),
                  const SettingsSectionHeader(title: 'UPCOMING MEDICATIONS'),
                  const UpcomingMedicationCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

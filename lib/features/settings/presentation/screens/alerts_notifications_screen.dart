import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/core/constants/haptics.dart';
import 'package:provider/provider.dart';
import 'package:ntentan/core/widgets/app_header.dart';

import 'package:ntentan/features/settings/presentation/widgets/dashboard_header.dart';
import 'package:ntentan/features/settings/presentation/widgets/dashboard_toggle_card.dart';
import 'package:ntentan/features/settings/presentation/controllers/accessibility_controller.dart';

class AlertsNotificationsScreen extends StatelessWidget {
  const AlertsNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accessibility = context.watch<AccessibilityController>();
    final state = accessibility.state;
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: const AppHeader(
        title: 'Alerts & Notifications',
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.space20),
        children: [
          const DashboardHeader(title: 'Core Notifications'),
          const SizedBox(height: AppSizes.space16),
          DashboardToggleCard(
            title: 'Medication Reminders',
            subtitle: 'Get notified when it\'s time for your dose',
            icon: Icons.medication_rounded,
            value: state.medicationRemindersEnabled,
            onChanged: (val) {
              AppHaptics.tap();
              accessibility.setMedicationRemindersEnabled(val);
              accessibility.saveSettings();
            },
          ),
          const SizedBox(height: AppSizes.space12),
          DashboardToggleCard(
            title: 'Emergency SOS Status',
            subtitle: 'Critical alerts regarding your safety contacts',
            icon: Icons.emergency_rounded,
            value: true,
            onChanged: (val) => AppHaptics.notification(),
            isCritical: true,
          ),
          const SizedBox(height: AppSizes.space32),
          const DashboardHeader(title: 'Accessibility Alerts'),
          const SizedBox(height: AppSizes.space16),
          DashboardToggleCard(
            title: 'Tactile Haptic Patterns',
            subtitle: 'Unique vibrations for different alert types',
            icon: Icons.vibration_rounded,
            value: state.vibrationEnabled,
            onChanged: (val) {
              AppHaptics.success();
              accessibility.setVibrationEnabled(val);
              accessibility.saveSettings();
            },
          ),
        ],
      ),
    );
  }
}

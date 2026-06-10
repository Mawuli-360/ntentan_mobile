import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:ntentan/core/app_route/route_paths.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';

import 'package:ntentan/core/constants/haptics.dart';
import 'package:ntentan/features/dashboard/presentation/widgets/dashboard_header.dart';
import 'package:ntentan/features/settings/presentation/controllers/accessibility_controller.dart';
import 'package:ntentan/shared/widgets/settings_item.dart';
import 'package:ntentan/shared/widgets/settings_section.dart';

import 'package:ntentan/features/dashboard/presentation/widgets/assistant_language_item.dart';
import 'package:ntentan/features/dashboard/presentation/widgets/delete_account_item.dart';
import 'package:ntentan/features/dashboard/presentation/widgets/logout_item.dart';

class DashboardProfileTab extends StatelessWidget {
  const DashboardProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header Section ──
            const DashboardHeader(title: 'Profile'),
            // ── Main Content ──
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSizes.space24),
                    SettingsSection(
                      title: 'Account Management',
                      children: [
                        SettingsItem(
                          icon: Iconsax.profile_2user,
                          iconColor: Colors.blueAccent,
                          label: 'Caregiver Mode',
                          subtitle: 'Add or manage medication helpers',
                          onTap: () => context.push(RoutePaths.caregiverMode),
                        ),
                        SettingsItem(
                          icon: Iconsax.calendar_1,
                          iconColor: Colors.purpleAccent,
                          label: 'Medication Schedule',
                          subtitle: 'Edit or remove scheduled medicines',
                          onTap: () =>
                              context.push(RoutePaths.medicationSchedule),
                        ),
                      ],
                    ),
                    SettingsSection(
                      title: 'Accessibility & Display',
                      children: [
                        Consumer<AccessibilityController>(
                          builder: (context, accessibility, _) => SettingsItem(
                            icon: Iconsax.search_zoom_in_1,
                            iconColor: Colors.amber,
                            label: 'Magnify Screen',
                            subtitle: 'Increase text and image sizes',
                            trailing: Switch(
                              value: accessibility.state.magnifyScreenEnabled,
                              onChanged: (v) {
                                AppHaptics.light();
                                accessibility.setMagnifyScreen(v);
                                accessibility.saveSettings();
                              },
                              activeColor: AppColors.vi,
                            ),
                          ),
                        ),
                        const AssistantLanguageItem(),
                        SettingsItem(
                          icon: Iconsax.colorfilter,
                          iconColor: Colors.tealAccent,
                          label: 'Visual Preferences',
                          onTap: () =>
                              context.push(RoutePaths.visualPreferences),
                        ),
                        SettingsItem(
                          icon: Iconsax.notification_bing,
                          iconColor: Colors.pinkAccent,
                          label: 'Alerts & Notifications',
                          onTap: () =>
                              context.push(RoutePaths.alertsNotifications),
                        ),
                      ],
                    ),
                    SettingsSection(
                      title: 'Support',
                      children: [
                        SettingsItem(
                          icon: Iconsax.message_question,
                          iconColor: Colors.lightBlueAccent,
                          label: 'Help Center',
                          onTap: () => context.push(RoutePaths.helpCenter),
                        ),
                      ],
                    ),
                    SettingsSection(
                      title: 'Account Actions',
                      children: const [
                        LogoutItem(),
                        DeleteAccountItem(),
                      ],
                    ),
                    const SizedBox(height: AppSizes.space12),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

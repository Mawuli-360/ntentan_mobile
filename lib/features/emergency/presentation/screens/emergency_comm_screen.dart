import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/core/widgets/app_header.dart';
import 'package:provider/provider.dart';
import 'package:ntentan/features/emergency/presentation/controllers/emergency_controller.dart';
import 'package:ntentan/features/emergency/presentation/widgets/emergency_alert_banner.dart';
import 'package:ntentan/features/emergency/presentation/widgets/emergency_info_row.dart';
import 'package:ntentan/features/emergency/presentation/widgets/emergency_contact_row.dart';

/// Smart Emergency Communication — Phase 5
/// Shows communication status with emergency contacts and responders.
class EmergencyCommScreen extends StatelessWidget {
  const EmergencyCommScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppHeader(
        title: 'Emergency Status',
        backgroundColor: AppColors.emergency.withValues(alpha: 0.1),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSizes.space24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Alert banner
              const EmergencyAlertBanner(),
              const SizedBox(height: AppSizes.space24),

              // Shared info
              Text('SHARED INFORMATION',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      letterSpacing: 2,
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              const EmergencyInfoRow(
                icon: Icons.location_on_rounded,
                label: 'GPS Location',
                status: 'Shared — accuracy: 5m',
                statusColor: AppColors.success,
              ),

              const EmergencyInfoRow(
                icon: Icons.language_rounded,
                label: 'Communication Needs',
                status: 'Sent (disability profile + preferred language)',
                statusColor: AppColors.success,
              ),

              const SizedBox(height: AppSizes.space24),

              // Contact status
              Text('CONTACTS NOTIFIED',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      letterSpacing: 2,
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              ...context.watch<EmergencyController>().state.notifiedContacts
                  .map((contact) => EmergencyContactRow(contact: contact)),

              const SizedBox(height: AppSizes.space24),

              // Post-emergency follow-up
              Container(
                padding: const EdgeInsets.all(AppSizes.space20),
                decoration: BoxDecoration(
                  color: AppColors.aiBg,
                  borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                  border: Border.all(color: AppColors.aiBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.auto_awesome,
                            color: AppColors.ai, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text('After Emergency',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(color: AppColors.ai)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'When you mark yourself as safe, we will ask:\n'
                      '• Are you injured?\n'
                      '• Do you need medical follow-up?\n'
                      '• Would you like to notify caregivers you are OK?',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: AppColors.textPrimary, height: 1.6),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

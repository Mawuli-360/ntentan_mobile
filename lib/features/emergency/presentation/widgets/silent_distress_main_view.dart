import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/features/emergency/presentation/widgets/silent_mode_banner.dart';
import 'package:ntentan/features/emergency/presentation/widgets/silent_status_row.dart';
import 'package:ntentan/core/widgets/accessible_widget.dart';
import 'package:ntentan/app/injection_container.dart';
import 'package:ntentan/core/services/accessibility/haptic_service.dart';

class SilentDistressMainView extends StatelessWidget {
  final VoidCallback onShowHelper;
  final VoidCallback onCancel;

  const SilentDistressMainView({
    super.key,
    required this.onShowHelper,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Status
        const SilentModeBanner(),
        const SizedBox(height: AppSizes.space24),

        // Emergency info is being sent silently
        Text('Silent alert has been sent to:',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.textPrimary)),
        const SizedBox(height: 12),

        const SilentStatusRow(icon: '📍', label: 'GPS location', status: 'Sharing continuously'),
        const SilentStatusRow(
            icon: '👨‍👩‍👧', label: 'Ama Mensah (Mother)', status: 'SMS sent silently'),
        const SilentStatusRow(
            icon: '📋', label: 'Medical profile', status: 'Shared with responders'),

        const Spacer(),

        // Show helper card button — for bystanders
        SizedBox(
          width: double.infinity,
          height: 72,
          child: AccessibleWidget(
            label: 'Show Helper Card',
            hint: 'Double tap to show visual instructions for bystanders',
            child: ElevatedButton(
              onPressed: () {
                sl<HapticService>().tapFeedback();
                onShowHelper();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.vi,
                foregroundColor: AppColors.bg,
                textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('🆘 Show Helper Card'),
            ),
          ),
        ),

        const SizedBox(height: AppSizes.space12),

        // Cancel
        SizedBox(
          width: double.infinity,
          height: 64,
          child: AccessibleWidget(
            label: 'Cancel Silent Mode',
            hint: 'Double tap to exit silent emergency mode',
            child: OutlinedButton(
              onPressed: () {
                sl<HapticService>().tapFeedback();
                onCancel();
              },
              style: OutlinedButton.styleFrom(
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              child: const Text('Cancel Silent Mode'),
            ),
          ),
        ),
      ],
    );
  }
}

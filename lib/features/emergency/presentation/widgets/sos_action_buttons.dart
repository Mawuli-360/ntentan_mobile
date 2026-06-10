import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/core/widgets/accessible_widget.dart';
import 'package:ntentan/app/injection_container.dart';
import 'package:ntentan/core/services/accessibility/haptic_service.dart';

class SOSActionButtons extends StatelessWidget {
  final bool sent;
  final VoidCallback onCancel;
  final VoidCallback onSilentMode;
  final VoidCallback onViewStatus;

  const SOSActionButtons({
    super.key,
    required this.sent,
    required this.onCancel,
    required this.onSilentMode,
    required this.onViewStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Silent mode
        if (!sent) ...[
          SizedBox(
            width: double.infinity,
            child: AccessibleWidget(
              label: 'Switch to Silent Mode',
              hint: 'Double tap to activate silent distress mode',
              child: OutlinedButton.icon(
                onPressed: () {
                  sl<HapticService>().tapFeedback();
                  onSilentMode();
                },
                icon: const Icon(Icons.volume_off_rounded, color: AppColors.vi),
                label: const Text('Switch to Silent Mode',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.vi)),
                style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    side: const BorderSide(color: AppColors.viBorder)),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.space12),
        ],

        if (sent) ...[
          SizedBox(
            width: double.infinity,
            child: AccessibleWidget(
              label: 'View Communication Status',
              hint: 'Double tap to check the status of your SOS alert',
              child: ElevatedButton(
                onPressed: () {
                  sl<HapticService>().tapFeedback();
                  onViewStatus();
                },
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                child: const Text('View Communication Status', textAlign: TextAlign.center),
              ),
            ),
          ),
          const SizedBox(height: AppSizes.space12),
        ],

        // CANCEL — largest button, bottom of screen
        SizedBox(
          width: double.infinity,
          child: AccessibleWidget(
            label: sent ? 'I Am Safe, Close' : 'Cancel SOS',
            hint: 'Double tap to cancel the emergency alert',
            child: ElevatedButton(
              onPressed: () {
                sl<HapticService>().tapFeedback();
                onCancel();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                backgroundColor: sent ? AppColors.surface2 : Colors.white,
                foregroundColor: sent ? AppColors.textPrimary : AppColors.bg,
                textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                sent ? 'I Am Safe — Close' : 'CANCEL',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

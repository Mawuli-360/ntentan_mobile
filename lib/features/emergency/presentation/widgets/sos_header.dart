import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/features/emergency/presentation/widgets/sos_countdown.dart';

class SOSHeader extends StatelessWidget {
  final bool sent;
  final bool sending;
  final int countdown;

  const SOSHeader({
    super.key,
    required this.sent,
    required this.sending,
    required this.countdown,
  });

  @override
  Widget build(BuildContext context) {
    if (!sent) {
      return MergeSemantics(
        child: Column(
          children: [
            const SizedBox(height: AppSizes.space32),
            SOSCountdown(
              countdown: countdown,
              isSending: sending,
            ),
            const SizedBox(height: AppSizes.space24),
            Text(
              sending ? 'Sending Emergency Alert...' : 'Emergency Alert',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.emergency,
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 8),
            ExcludeSemantics(
              child: Text(
                sending
                    ? 'Contacting help and caregivers'
                    : 'Sending SOS alert in $countdown seconds',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.textSecondary),
              ),
            ),
          ],
        ),
      );
    } else {
      return MergeSemantics(
        child: Column(
          children: [
            const SizedBox(height: AppSizes.space32),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.success.withValues(alpha: 0.15),
                border: Border.all(color: AppColors.success, width: 3),
              ),
              child: const ExcludeSemantics(
                child: Icon(Icons.check_rounded,
                    size: 48, color: AppColors.success),
              ),
            ),
            const SizedBox(height: AppSizes.space24),
            Semantics(
              label: 'Success. Help is on the way.',
              child: Text('Help is on the way',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.success, fontWeight: FontWeight.w800)),
            ),
          ],
        ),
      );
    }
  }
}

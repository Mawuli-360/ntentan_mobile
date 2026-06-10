import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/shared/widgets/feature_tag.dart';
import 'package:ntentan/features/visually_impaired/camera_reader/presentation/state/med_scanner_state.dart';

class ScanResultPanel extends StatelessWidget {
  final MedScannerState state;

  const ScanResultPanel({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.space20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──
            Row(
              children: [
                const Icon(Icons.document_scanner_rounded,
                    color: AppColors.vi, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Scan Result',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.white),
                ),
                const Spacer(),
                const FeatureTag(label: 'Live Scan', type: TrackType.vi),
              ],
            ),
            const SizedBox(height: AppSizes.space12),

            // ── Dynamic Content ──
            _buildDynamicResultContent(context),

            const SizedBox(height: AppSizes.space12),

            // ── Helper Tip ──
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.sharedBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '💡 Ensure good lighting. The tracker beep gets faster as you center the label.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.shared,
                      fontSize: 12,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDynamicResultContent(BuildContext context) {
    switch (state.phase) {
      case ScanPhase.idle:
      case ScanPhase.connecting:
      case ScanPhase.scanning:
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSizes.space16),
          decoration: BoxDecoration(
            color: AppColors.surface2,
            borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              if (state.phase == ScanPhase.connecting)
                const CircularProgressIndicator(color: AppColors.vi),
              if (state.phase == ScanPhase.connecting)
                const SizedBox(height: 16),
              Text(
                state.phase == ScanPhase.idle
                    ? 'Camera ready. Waiting to start scan...'
                    : state.phase == ScanPhase.connecting
                        ? 'Connecting to real-time AI...'
                        : 'Scanning... Please hold steady.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );

      case ScanPhase.success:
        final match = state.lastResponse?.prescriptionMatch;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSizes.space16),
          decoration: BoxDecoration(
            color: AppColors.viBg.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            border: Border.all(color: AppColors.viBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 24),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      match != null
                          ? match.medication.name
                          : 'Medication Found',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );

      case ScanPhase.error:
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSizes.space16),
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
          ),
          child: Column(
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 32),
              const SizedBox(height: 8),
              Text(
                state.errorMessage ?? 'An unknown error occurred.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.red,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
    }
  }
}

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/features/visually_impaired/camera_reader/presentation/state/med_scanner_state.dart';
import 'package:ntentan/features/visually_impaired/camera_reader/presentation/widgets/corner_marker.dart';

class CameraViewfinder extends StatelessWidget {
  final CameraController? controller;
  final MedScannerState state;

  const CameraViewfinder({
    super.key,
    required this.controller,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final isReady = controller != null && controller!.value.isInitialized;

    return Container(
      margin: const EdgeInsets.all(AppSizes.space16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusXL),
        border: Border.all(
          color: state.phase == ScanPhase.success 
              ? Colors.green 
              : AppColors.viBorder, 
          width: state.phase == ScanPhase.success ? 4 : 2,
        ),
      ),
      child: Stack(
        children: [
          // ── Camera Feed or Placeholder ──
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.radiusXL - 2),
              child: isReady
                  ? _buildCameraFeed(context)
                  : _buildPlaceholder(context),
            ),
          ),

          // ── Corner Markers ──
          const Positioned(top: 16, left: 16, child: CornerMarker(color: AppColors.vi, size: 24, top: true, left: true)),
          const Positioned(top: 16, right: 16, child: CornerMarker(color: AppColors.vi, size: 24, top: true, left: false)),
          const Positioned(bottom: 16, left: 16, child: CornerMarker(color: AppColors.vi, size: 24, top: false, left: true)),
          const Positioned(bottom: 16, right: 16, child: CornerMarker(color: AppColors.vi, size: 24, top: false, left: false)),

          // ── Overlay Elements ──
          if (isReady && state.phase == ScanPhase.scanning)
             _buildOverlayMessage(context),
        ],
      ),
    );
  }

  Widget _buildCameraFeed(BuildContext context) {
    // The camera feed might be a different aspect ratio than the container.
    // Use an AspectRatio wrapped in a FittedBox to center-crop the preview.
    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(
        width: controller!.value.previewSize?.height ?? 1,
        height: controller!.value.previewSize?.width ?? 1,
        child: CameraPreview(controller!),
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           const Icon(Icons.camera_alt_rounded, color: AppColors.vi, size: 48),
           const SizedBox(height: AppSizes.space16),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: AppSizes.space24),
             child: Text(
               state.errorMessage ?? 'Initializing camera...',
               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                     color: state.errorMessage != null 
                             ? Colors.red 
                             : AppColors.textSecondary,
                   ),
               textAlign: TextAlign.center,
             ),
           ),
        ],
      ),
    );
  }

  Widget _buildOverlayMessage(BuildContext context) {
    return Positioned(
      bottom: 24,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: AppSizes.space24),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.viBg.withValues(alpha: 0.9), // adjusted transparency
            borderRadius: BorderRadius.circular(AppSizes.radiusRound),
            border: Border.all(color: AppColors.viBorder),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.center_focus_weak, color: AppColors.vi, size: 18),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  state.guidanceText,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ) ?? const TextStyle(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

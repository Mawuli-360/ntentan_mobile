import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:audio_waveforms/audio_waveforms.dart';

class VoiceMicButton extends StatelessWidget {
  final bool isRecording;
  final VoidCallback onTap;
  final RecorderController? recorderController;

  const VoiceMicButton({
    super.key,
    required this.isRecording,
    required this.onTap,
    this.recorderController,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Semantics(
        button: true,
        label: isRecording ? 'Recording. Tap to stop and send.' : 'Tap to record voice message.',
        child: AnimatedContainer(
          duration: AppSizes.animNormal,
          width: isRecording ? 200 : 72,
          height: isRecording ? 88 : 72,
          decoration: BoxDecoration(
            color: isRecording ? AppColors.vi : AppColors.surface,
            borderRadius: BorderRadius.circular(isRecording ? 44 : 36),
            border: Border.all(
              color: isRecording ? AppColors.vi : AppColors.border,
              width: 3,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isRecording && recorderController != null) ...[
                const SizedBox(width: 16),
                Expanded(
                  child: AudioWaveforms(
                    enableGesture: false,
                    size: const Size(double.infinity, 40),
                    recorderController: recorderController!,
                    waveStyle: const WaveStyle(
                      waveColor: AppColors.bg,
                      extendWaveform: true,
                      showMiddleLine: false,
                      waveCap: StrokeCap.round,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Padding(
                padding: EdgeInsets.symmetric(horizontal: isRecording ? 16.0 : 0),
                child: Icon(
                  isRecording ? Icons.stop_rounded : Icons.mic_none_rounded,
                  color: isRecording ? AppColors.bg : AppColors.vi,
                  size: 36,
                ),
              ),
            ],
          ),
        )
            .animate(target: isRecording ? 1.0 : 0.0)
            .scale(
                begin: const Offset(1, 1),
                end: const Offset(1.05, 1.05),
                duration: 800.ms)
            .then()
            .scale(
                begin: const Offset(1.05, 1.05),
                end: const Offset(1, 1),
                duration: 800.ms),
      ),
    );
  }
}

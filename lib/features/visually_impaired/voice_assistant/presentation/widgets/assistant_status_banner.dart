import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/features/visually_impaired/voice_assistant/presentation/state/assistant_state.dart';

class AssistantStatusBanner extends StatelessWidget {
  final AssistantPhase phase;
  final String? errorMessage;

  const AssistantStatusBanner({
    super.key,
    required this.phase,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (phase == AssistantPhase.idle) return const SizedBox.shrink();

    final isError = phase == AssistantPhase.error;
    final bgColor = isError ? AppColors.error.withValues(alpha: 0.1) : AppColors.vi.withValues(alpha: 0.1);
    final fgColor = isError ? AppColors.error : AppColors.vi;

    String text = '';
    switch (phase) {
      case AssistantPhase.listening:
        text = 'Listening...';
        break;
      case AssistantPhase.sending:
        text = 'Sending recording...';
        break;
      case AssistantPhase.thinking:
        text = 'Assistant is typing...';
        break;
      case AssistantPhase.error:
        text = errorMessage ?? 'An error occurred';
        break;
      default:
        break;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.space8,
        horizontal: AppSizes.space16,
      ),
      color: bgColor,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: fgColor,
              fontWeight: FontWeight.w500,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

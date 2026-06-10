import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';

class VoiceMessageBubble extends StatelessWidget {
  final bool isUser;
  final String text;

  const VoiceMessageBubble({
    super.key,
    required this.isUser,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.space12),
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.8,
          ),
          padding: const EdgeInsets.all(AppSizes.space16),
          decoration: BoxDecoration(
            color: isUser
                ? AppColors.vi.withValues(alpha: 0.15)
                : AppColors.surface,
            border: Border.all(
              color: isUser ? AppColors.viBorder : AppColors.border,
            ),
            borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isUser ? '🗣 You' : '🤖 Ntentan',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: isUser ? AppColors.vi : AppColors.ai,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textPrimary,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

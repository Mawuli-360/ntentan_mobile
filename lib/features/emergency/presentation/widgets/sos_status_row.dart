import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';

class SOSStatusRow extends StatelessWidget {
  final String label;
  final bool isDone;

  const SOSStatusRow({
    super.key,
    required this.label,
    required this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDone
            ? AppColors.success.withValues(alpha: 0.08)
            : AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: isDone
                ? AppColors.success.withValues(alpha: 0.2)
                : AppColors.border),
      ),
      child: Row(
        children: [
          Icon(
              isDone ? Icons.check_circle_rounded : Icons.hourglass_empty_rounded,
              color: isDone ? AppColors.success : AppColors.textMuted,
              size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDone ? AppColors.success : AppColors.textSecondary)),
          ),
        ],
      ),
    );
  }
}

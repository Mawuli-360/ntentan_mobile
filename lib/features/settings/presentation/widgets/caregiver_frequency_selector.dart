import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';

class CaregiverFrequencySelector extends StatelessWidget {
  final int selectedFrequency;
  final ValueChanged<int> onFrequencySelected;

  const CaregiverFrequencySelector({
    super.key,
    required this.selectedFrequency,
    required this.onFrequencySelected,
  });

  static const _options = [
    (label: '1x', value: 1, sub: 'daily'),
    (label: '2x', value: 2, sub: 'daily'),
    (label: '3×', value: 3, sub: 'daily'),
    (label: '4×', value: 4, sub: 'daily'),
    (label: 'PRN', value: 0, sub: 'as needed'),
  ];

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _options.map((opt) {
          final isSelected = selectedFrequency == opt.value;
          return Expanded(
            child: GestureDetector(
              onTap: () => onFrequencySelected(opt.value),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 6),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.vi.withValues(alpha: 0.15)
                      : AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? AppColors.vi : AppColors.border,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      opt.label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:
                            isSelected ? AppColors.vi : AppColors.textPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      opt.sub,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isSelected
                            ? AppColors.vi.withValues(alpha: 0.8)
                            : AppColors.textSecondary,
                        fontSize: 10,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

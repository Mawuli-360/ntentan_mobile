import 'package:flutter/material.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/core/constants/haptics.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ColorBlindnessGrid extends StatelessWidget {
  final List<Map<String, String>> modes;
  final int selectedIndex;
  final Function(int) onSelected;

  const ColorBlindnessGrid({
    super.key,
    required this.modes,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.4,
      ),
      itemCount: modes.length,
      itemBuilder: (context, index) {
        final mode = modes[index];
        final isSelected = index == selectedIndex;
        return InkWell(
          onTap: () {
            AppHaptics.tap();
            onSelected(index);
          },
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          child: AnimatedContainer(
            duration: 200.ms,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.vi.withValues(alpha: 0.1)
                  : AppColors.surface,
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
              border: Border.all(
                color: isSelected ? AppColors.vi : AppColors.border,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(mode['name']!,
                    style: TextStyle(
                        color: isSelected ? AppColors.vi : Colors.white,
                        fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(mode['desc']!,
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 10)),
              ],
            ),
          ),
        );
      },
    );
  }
}

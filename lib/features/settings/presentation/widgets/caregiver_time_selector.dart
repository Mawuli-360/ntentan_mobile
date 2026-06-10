import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/core/constants/enums.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CaregiverTimeSelector extends StatelessWidget {
  final Set<MedTimeSlot> selectedSlots;
  final ValueChanged<MedTimeSlot> onSlotToggled;

  const CaregiverTimeSelector({
    super.key,
    required this.selectedSlots,
    required this.onSlotToggled,
  });

  @override
  Widget build(BuildContext context) {
    // If "As Needed" is selected, we disable other options
    final isAsNeeded = selectedSlots.contains(MedTimeSlot.asNeeded);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          Row(
            children: MedTimeSlot.values.where((v) => v != MedTimeSlot.asNeeded).map((slot) {
              final isSelected = selectedSlots.contains(slot);
              final isDisabled = isAsNeeded;
              
              Color activeColor;
              IconData icon;

              switch (slot) {
                case MedTimeSlot.morning:
                  activeColor = Colors.orangeAccent;
                  icon = Iconsax.sun_1;
                case MedTimeSlot.afternoon:
                  activeColor = Colors.blueAccent;
                  icon = Iconsax.cloud_sunny;
                case MedTimeSlot.evening:
                  activeColor = Colors.deepOrangeAccent;
                  icon = Iconsax.cloud_notif;
                case MedTimeSlot.night:
                  activeColor = Colors.indigoAccent;
                  icon = Iconsax.moon;
                default:
                  activeColor = AppColors.vi;
                  icon = Iconsax.mask_1;
              }

              return Expanded(
                child: Opacity(
                  opacity: isDisabled ? 0.3 : 1.0,
                  child: GestureDetector(
                    onTap: isDisabled ? null : () => onSlotToggled(slot),
                    child: AnimatedContainer(
                      duration: 300.ms,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? activeColor.withValues(alpha: 0.15)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                        border: isSelected
                            ? Border.all(color: activeColor.withValues(alpha: 0.5))
                            : Border.all(color: Colors.transparent),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            icon,
                            color: isSelected ? activeColor : AppColors.textMuted,
                            size: 22,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            slot.label,
                            style: TextStyle(
                              color: isSelected ? Colors.white : AppColors.textMuted,
                              fontSize: 10,
                              fontWeight:
                                  isSelected ? FontWeight.w700 : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const Divider(color: AppColors.border, height: 1),
          GestureDetector(
            onTap: () => onSlotToggled(MedTimeSlot.asNeeded),
            child: AnimatedContainer(
              duration: 300.ms,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: isAsNeeded
                    ? AppColors.vi.withValues(alpha: 0.15)
                    : Colors.transparent,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.mask_1,
                    color: isAsNeeded ? AppColors.vi : AppColors.textMuted,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'As Needed (PRN)',
                    style: TextStyle(
                      color: isAsNeeded ? Colors.white : AppColors.textMuted,
                      fontSize: 13,
                      fontWeight: isAsNeeded ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

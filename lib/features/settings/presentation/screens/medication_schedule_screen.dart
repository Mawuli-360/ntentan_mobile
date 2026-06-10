import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ntentan/core/app_route/route_paths.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/core/widgets/app_header.dart';
import 'package:ntentan/features/settings/presentation/controllers/medication_controller.dart';
import 'package:ntentan/features/settings/domain/entities/medication.dart';
import 'package:ntentan/core/constants/enums.dart';
import 'package:provider/provider.dart';
import 'package:ntentan/core/extension/context.dart';

class MedicationScheduleScreen extends StatelessWidget {
  const MedicationScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final medicationController = context.watch<MedicationController>();
    final medications = medicationController.state.medications;

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: const AppHeader(title: 'Medication Schedule'),
      body: medications.isEmpty
          ? _buildEmptyState(context)
          : ListView.separated(
              padding: const EdgeInsets.all(AppSizes.space16),
              itemCount: medications.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppSizes.space12),
              itemBuilder: (context, index) {
                final med = medications[index];
                return _MedicationListTile(medication: med);
              },
            ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Iconsax.mask_1, size: 64, color: AppColors.textMuted),
          const SizedBox(height: 16),
          Text(
            'No medications scheduled',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ],
      ),
    );
  }
}

class _MedicationListTile extends StatelessWidget {
  final Medication medication;

  const _MedicationListTile({required this.medication});

  bool _isSameDayLocal(DateTime? date, DateTime now) {
    if (date == null) return false;
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Dismissible(
      key: Key(medication.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: AppColors.emergency,
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        ),
        child: const Icon(Iconsax.trash, color: Colors.white),
      ),
      onDismissed: (_) {
        context.read<MedicationController>().deleteMedication(medication.id);
        context.showSuccessSnackBar('${medication.name} removed');
      },
      child: Container(
        padding: const EdgeInsets.all(AppSizes.space16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Column(
              children: medication.timeSlots.map((slot) {
                final isCompleted = _isSameDayLocal(medication.completedSlots[slot.name], now);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: InkWell(
                    onTap: () => context.read<MedicationController>().toggleSlotCompletion(medication.id, slot),
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? AppColors.vi.withValues(alpha: 0.2)
                            : AppColors.vi.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(6),
                        border: isCompleted
                          ? Border.all(color: AppColors.vi, width: 1)
                          : null,
                      ),
                      child: Icon(
                        slot.iconData,
                        color: isCompleted ? AppColors.vi : AppColors.textMuted,
                        size: 16,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    medication.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '${medication.unitsPerDose} x ${medication.strength.isEmpty ? 'units' : medication.strength}',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 4,
                    children: medication.timeSlots.map((slot) {
                      final isCompleted = _isSameDayLocal(medication.completedSlots[slot.name], now);
                      return Text(
                        slot.label,
                        style: TextStyle(
                          color: isCompleted
                              ? AppColors.vi
                              : AppColors.textMuted,
                          fontSize: 11,
                          fontWeight: isCompleted
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Iconsax.edit_2, size: 18, color: AppColors.textMuted),
              onPressed: () {
                context.push(RoutePaths.caregiverMode, extra: medication);
              },
            ),
          ],
        ),
      ),
    );
  }
}

extension on MedTimeSlot {
  IconData get iconData {
    switch (this) {
      case MedTimeSlot.morning:
        return Iconsax.sun_1;
      case MedTimeSlot.afternoon:
        return Iconsax.sun;
      case MedTimeSlot.evening:
        return Iconsax.cloud_sunny;
      case MedTimeSlot.night:
        return Iconsax.moon;
      case MedTimeSlot.asNeeded:
        return Iconsax.flash;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:ntentan/core/constants/app_images.dart';
import 'package:ntentan/core/theme/app_colors.dart';
import 'package:ntentan/core/constants/app_sizes.dart';
import 'package:ntentan/core/constants/enums.dart';
import 'package:provider/provider.dart';
import 'package:ntentan/features/settings/presentation/controllers/medication_controller.dart';
import 'package:ntentan/features/settings/domain/entities/medication.dart';

class UpcomingMedicationCard extends StatelessWidget {
  const UpcomingMedicationCard({
    super.key,
  });

  bool _isSameDayLocal(DateTime? date, DateTime now) {
    if (date == null) return false;
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  @override
  Widget build(BuildContext context) {
    // Logic to find the "next" medication
    final medicationState = context.watch<MedicationController>().state;
    final medications = medicationState.medications;

    if (medications.isEmpty) return _buildEmptyState(context);

    final now = DateTime.now();

    // Flatten all untaken slots
    final untakenSlots = medications.expand((med) {
      return med.timeSlots.where((slot) {
        final completedAt = med.completedSlots[slot.name];
        return !_isSameDayLocal(completedAt, now);
      }).map((slot) => _NextMed(med: med, slot: slot));
    }).toList();

    // Sort by slot index to find the "earliest" next one
    untakenSlots.sort((a, b) => a.slot.index.compareTo(b.slot.index));

    if (untakenSlots.isEmpty) return _buildEmptyState(context);

    final next = untakenSlots.first;
    final Medication medication = next.med;
    final slot = next.slot;
    final isOverdue = slot.isOverdue;

    // Colors matching the teal reference design
    final cardBgColor =
        isOverdue ? Colors.red.withValues(alpha: 0.1) : AppColors.surface;
    final cardBorderColor =
        isOverdue ? Colors.redAccent : const Color(0xFF38B2B4);
    final accentCyan = isOverdue ? Colors.redAccent : const Color(0xFF3EE6E6);
    final buttonGreen = isOverdue ? Colors.redAccent : const Color(0xFF82D95C);

    // Format the time range
    String displayTime = slot.timeRange;
    if (displayTime.contains(' - ')) {
      displayTime = displayTime.split(' - ').first;
    }

    return Container(
      padding: const EdgeInsets.all(AppSizes.space20),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(AppSizes.radiusXL),
        border: Border.all(color: cardBorderColor, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: accentCyan.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image(image: AppImages.pill),
                ),
              ),
              const SizedBox(width: AppSizes.space16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            medication.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${medication.strength.isEmpty ? medication.dosage : medication.strength} • ${slot.label}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    const SizedBox(height: AppSizes.space4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.access_time, color: accentCyan, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          displayTime,
                          style: TextStyle(
                            color: accentCyan,
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.space12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: (slot.isCurrent || isOverdue)
                      ? () {
                          context
                              .read<MedicationController>()
                              .toggleSlotCompletion(medication.id, slot);
                        }
                      : null,
                  icon: Icon(
                    isOverdue
                        ? Icons.warning_amber_rounded
                        : (slot.isCurrent ? Icons.check : Icons.lock_outline),
                    size: 20,
                  ),
                  label: Text(
                    isOverdue
                        ? 'Overdue - Take Now'
                        : (slot.isCurrent ? 'Taken' : 'Locked'),
                    style: const TextStyle(
                        fontWeight: FontWeight.w900, fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonGreen,
                    foregroundColor: Colors.black87,
                    disabledBackgroundColor:
                        Colors.black.withValues(alpha: 0.2),
                    disabledForegroundColor: Colors.white70,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSizes.radiusMedium),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          vertical: AppSizes.space32, horizontal: AppSizes.space20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusXL),
        border: Border.all(color: AppColors.borderLight, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Opacity(
            opacity: 0.5,
            child: Image(
              image: AppImages.drug,
              width: 60,
              height: 60,
            ),
          ),
          const SizedBox(height: AppSizes.space16),
          Text(
            'No medications yet',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white54,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}

class _NextMed {
  final dynamic med;
  final MedTimeSlot slot;
  _NextMed({required this.med, required this.slot});
}

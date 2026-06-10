import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ntentan/features/settings/domain/entities/medication.dart';

import 'package:ntentan/core/constants/enums.dart';

part 'medication_state.freezed.dart';

@freezed
sealed class MedicationState with _$MedicationState {
  const MedicationState._();

  const factory MedicationState.initial({
    @Default([]) List<Medication> medications,
  }) = MedicationInitial;

  const factory MedicationState.loading({
    required List<Medication> medications,
  }) = MedicationLoading;

  const factory MedicationState.loaded({
    required List<Medication> medications,
  }) = MedicationLoaded;

  const factory MedicationState.error({
    required List<Medication> medications,
    required String message,
  }) = MedicationError;

  bool get isLoading => this is MedicationLoading;

  String? get error => switch (this) {
        MedicationError(message: final m) => m,
        _ => null,
      };

  List<String> get untakenMedicationsToday {
    final now = DateTime.now();
    final List<String> untakenMedsList = [];

    for (final med in medications) {
      final List<String> untakenSlotsForMed = [];
      for (final slot in med.timeSlots) {
        if (slot == MedTimeSlot.asNeeded) continue;

        final completedAt = med.completedSlots[slot.name]?.toLocal();
        if (completedAt == null ||
            completedAt.year != now.year ||
            completedAt.month != now.month ||
            completedAt.day != now.day) {
          untakenSlotsForMed.add(slot.name);
        }
      }
      
      if (untakenSlotsForMed.isNotEmpty) {
        if (untakenSlotsForMed.length == 1) {
          untakenMedsList.add('${med.name} in the ${untakenSlotsForMed.first}');
        } else {
          final last = untakenSlotsForMed.last;
          final others = untakenSlotsForMed.sublist(0, untakenSlotsForMed.length - 1).join(', ');
          untakenMedsList.add('${med.name} in the $others, and $last');
        }
      }
    }
    return untakenMedsList;
  }
}

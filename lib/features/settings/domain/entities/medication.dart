import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ntentan/core/constants/enums.dart';

part 'medication.freezed.dart';
part 'medication.g.dart';

@freezed
abstract class Medication with _$Medication {
  const factory Medication({
    required String id,
    required String name,
    required String dosage,
    @Default('') String strength,
    @Default(1) int unitsPerDose,
    @Default(1) int frequency,
    required List<MedTimeSlot> timeSlots,
    @Default({}) Map<String, DateTime> completedSlots,
    required String instruction,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Medication;

  factory Medication.fromJson(Map<String, dynamic> json) => _$MedicationFromJson(json);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Medication _$MedicationFromJson(Map<String, dynamic> json) => _Medication(
      id: json['id'] as String,
      name: json['name'] as String,
      dosage: json['dosage'] as String,
      strength: json['strength'] as String? ?? '',
      unitsPerDose: (json['unitsPerDose'] as num?)?.toInt() ?? 1,
      frequency: (json['frequency'] as num?)?.toInt() ?? 1,
      timeSlots: (json['timeSlots'] as List<dynamic>)
          .map((e) => $enumDecode(_$MedTimeSlotEnumMap, e))
          .toList(),
      completedSlots: (json['completedSlots'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, DateTime.parse(e as String)),
          ) ??
          const {},
      instruction: json['instruction'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$MedicationToJson(_Medication instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'dosage': instance.dosage,
      'strength': instance.strength,
      'unitsPerDose': instance.unitsPerDose,
      'frequency': instance.frequency,
      'timeSlots':
          instance.timeSlots.map((e) => _$MedTimeSlotEnumMap[e]!).toList(),
      'completedSlots': instance.completedSlots
          .map((k, e) => MapEntry(k, e.toIso8601String())),
      'instruction': instance.instruction,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$MedTimeSlotEnumMap = {
  MedTimeSlot.morning: 'morning',
  MedTimeSlot.afternoon: 'afternoon',
  MedTimeSlot.evening: 'evening',
  MedTimeSlot.night: 'night',
  MedTimeSlot.asNeeded: 'asNeeded',
};

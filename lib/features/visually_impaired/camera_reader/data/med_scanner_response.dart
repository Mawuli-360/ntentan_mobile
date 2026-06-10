//
//  med_scanner_response.dart
//  ntentan
//

class MedicationRecord {
  final String name;
  final String dosage;
  final String instruction;
  final String compositeString;
  final int? frequency;
  final num? unitsPerDose;
  final List<String> timeSlots;

  MedicationRecord({
    required this.name,
    required this.dosage,
    required this.instruction,
    required this.compositeString,
    this.frequency,
    this.unitsPerDose,
    required this.timeSlots,
  });

  factory MedicationRecord.fromJson(Map<String, dynamic> json) {
    return MedicationRecord(
      name: json['name'] as String? ?? 'Unknown',
      dosage: json['dosage'] as String? ?? '',
      instruction: json['instruction'] as String? ?? '',
      compositeString: json['composite_string'] as String? ?? '',
      frequency: json['frequency'] as int?,
      unitsPerDose: json['unitsPerDose'] as num?,
      timeSlots: (json['timeSlots'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }
}

class PrescriptionMatch {
  final MedicationRecord medication;
  final double distance;
  final bool withinThreshold;

  PrescriptionMatch({
    required this.medication,
    required this.distance,
    required this.withinThreshold,
  });

  factory PrescriptionMatch.fromJson(Map<String, dynamic> json) {
    return PrescriptionMatch(
      medication: MedicationRecord.fromJson(json['medication'] as Map<String, dynamic>),
      distance: (json['distance'] as num?)?.toDouble() ?? 1.0,
      withinThreshold: json['withinThreshold'] as bool? ?? false,
    );
  }
}

class MedScannerResponse {
  final String status;
  final String instruction;
  final String guidanceText;
  final PrescriptionMatch? prescriptionMatch;

  MedScannerResponse({
    required this.status,
    required this.instruction,
    required this.guidanceText,
    this.prescriptionMatch,
  });

  factory MedScannerResponse.fromJson(Map<String, dynamic> json) {
    return MedScannerResponse(
      status: json['status'] as String? ?? 'no_object',
      instruction: json['instruction'] as String? ?? 'none',
      guidanceText: json['guidance_text'] as String? ?? '',
      prescriptionMatch: json['prescription_match'] != null
          ? PrescriptionMatch.fromJson(json['prescription_match'] as Map<String, dynamic>)
          : null,
    );
  }
}

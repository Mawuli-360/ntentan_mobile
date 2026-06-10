class NotifiedContact {
  final String name;
  final String phoneNumber;
  final bool success;

  NotifiedContact({
    required this.name,
    required this.phoneNumber,
    required this.success,
  });

  factory NotifiedContact.fromJson(Map<String, dynamic> json) {
    return NotifiedContact(
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      success: json['success'] as bool,
    );
  }
}

class MedicalAlertResponse {
  final String status;
  final List<NotifiedContact> notifiedContacts;

  MedicalAlertResponse({
    required this.status,
    required this.notifiedContacts,
  });

  factory MedicalAlertResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    final contactsList = data['notified_contacts'] as List<dynamic>? ?? [];
    
    return MedicalAlertResponse(
      status: json['status'] as String? ?? 'unknown',
      notifiedContacts: contactsList
          .map((c) => NotifiedContact.fromJson(c as Map<String, dynamic>))
          .toList(),
    );
  }
}

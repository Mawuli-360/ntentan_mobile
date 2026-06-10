//
//  assistant_message.dart
//  ntentan
//
//

class UserMessage {
  final String type; // 'text' or 'audio'
  final dynamic content; // String for text, Uint8List for audio
  final String language; // 'english' or 'twi'

  UserMessage({
    required this.type,
    required this.content,
    required this.language,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'content': content, // Now expects Base64 String for audio
      'language': language,
    };
  }
}

class AssistantResponse {
  final String status;
  final String content;
  final List<Map<String, dynamic>> history;
  final String? audioBase64;

  AssistantResponse({
    required this.status,
    required this.content,
    required this.history,
    this.audioBase64,
  });

  factory AssistantResponse.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      final data = json['data'] as Map<String, dynamic>? ?? {};
      return AssistantResponse(
        status: json['status'] as String? ?? 'success',
        content: data['message'] as String? ?? '',
        history: List<Map<String, dynamic>>.from(data['history'] ?? []),
        audioBase64: data['audio'] as String?,
      );
    }
    return AssistantResponse(status: 'error', content: '', history: []);
  }
}

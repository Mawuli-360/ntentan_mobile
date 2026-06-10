import 'package:ntentan/core/api/api_client.dart';
import 'package:ntentan/core/constants/logger.dart';
import 'package:ntentan/features/visually_impaired/voice_assistant/data/assistant_message.dart';

class AssistantRestService {
  List<Map<String, dynamic>> _history = [];

  Future<AssistantResponse> chat({
    required String baseUrl,
    required UserMessage message,
  }) async {
    final apiClient = ApiClient(baseUrl: baseUrl);

    AppLogger.i(
        'Sending message to Assistant REST API: ${message.type} (${message.language})');

    try {
      final response = await apiClient.post(
        '/api/assistant/chat',
        data: {
          'query': {
            'content': message.content,
            'type': message.type,
          },
          'history': _history,
          'language': message.language.toLowerCase(),
        },
      );

      final assistantResponse = AssistantResponse.fromJson(response);

      // Update local history with the new history returned from the server
      _history = assistantResponse.history;

      return assistantResponse;
    } catch (e) {
      AppLogger.e('Assistant REST API error: $e');
      rethrow;
    }
  }

  void resetHistory() {
    _history = [];
  }
}

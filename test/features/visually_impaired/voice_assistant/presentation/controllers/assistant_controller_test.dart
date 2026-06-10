import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ntentan/core/services/tts_service.dart';
import 'package:ntentan/features/visually_impaired/voice_assistant/data/assistant_message.dart';
import 'package:ntentan/features/visually_impaired/voice_assistant/data/assistant_rest_service.dart';
import 'package:ntentan/features/visually_impaired/voice_assistant/data/assistant_media_service.dart';
import 'package:ntentan/features/visually_impaired/voice_assistant/presentation/controllers/assistant_controller.dart';
import 'package:ntentan/features/visually_impaired/voice_assistant/presentation/state/assistant_state.dart';

class MockAssistantRestService extends Mock implements AssistantRestService {}
class MockAssistantMediaService extends Mock implements AssistantMediaService {}
class MockTtsService extends Mock implements TtsService {}

class FakeUserMessage extends Fake implements UserMessage {}

void main() {
  late AssistantController controller;
  late MockAssistantRestService mockRestService;
  late MockAssistantMediaService mockMediaService;
  late MockTtsService mockTtsService;

  setUpAll(() {
    registerFallbackValue(FakeUserMessage());
    dotenv.testLoad(fileInput: '''
API_BASE_URL=https://test.com
''');
  });

  setUp(() {
    mockRestService = MockAssistantRestService();
    mockMediaService = MockAssistantMediaService();
    mockTtsService = MockTtsService();

    controller = AssistantController(
      restService: mockRestService,
      mediaService: mockMediaService,
      ttsService: mockTtsService,
    );
  });

  group('Messaging', () {
    test('sendText should update state and send message', () async {
      when(() => mockRestService.chat(baseUrl: any(named: 'baseUrl'), message: any(named: 'message')))
          .thenAnswer((_) async => AssistantResponse(status: 'success', content: 'Hello', history: []));
      when(() => mockTtsService.speak(any(), language: any(named: 'language'))).thenAnswer((_) async {});

      await controller.sendText('Hi AI');

      // Wait for async
      await Future.delayed(const Duration(milliseconds: 100));
      expect(controller.state, isA<AssistantIdle>());
      
      expect(controller.state.messages.length, 2); // User + AI
      expect(controller.state.messages.last.isUser, false);
      expect(controller.state.messages.last.text, 'Hello');
      verify(() => mockTtsService.speak('Hello', language: 'english')).called(1);
    });

    test('sendText should set error on failure', () async {
      when(() => mockRestService.chat(baseUrl: any(named: 'baseUrl'), message: any(named: 'message')))
          .thenThrow(Exception('Network Error'));

      await controller.sendText('Hi AI');

      expect(controller.state, isA<AssistantError>());
    });
  });

  group('Audio Recording', () {
    test('startRecording should check permission and set listening', () async {
      when(() => mockMediaService.checkPermission()).thenAnswer((_) async => true);
      when(() => mockTtsService.stop()).thenAnswer((_) async {});
      when(() => mockMediaService.startRecording()).thenAnswer((_) async {});

      await controller.startRecording();

      expect(controller.state, isA<AssistantListening>());
      verify(() => mockMediaService.startRecording()).called(1);
    });

    test('stopRecording should get audio and send message', () async {
      // Setup state to listening
      when(() => mockMediaService.checkPermission()).thenAnswer((_) async => true);
      when(() => mockTtsService.stop()).thenAnswer((_) async {});
      when(() => mockMediaService.startRecording()).thenAnswer((_) async {});
      await controller.startRecording();

      // Stop recording
      when(() => mockMediaService.stopRecordingAndGetBase64()).thenAnswer((_) async => 'base64audio');
      when(() => mockRestService.chat(baseUrl: any(named: 'baseUrl'), message: any(named: 'message')))
          .thenAnswer((_) async => AssistantResponse(status: 'success', content: 'Audio received', history: []));
      when(() => mockTtsService.speak(any(), language: any(named: 'language'))).thenAnswer((_) async {});

      await controller.stopRecording();

      await Future.delayed(const Duration(milliseconds: 100));
      expect(controller.state, isA<AssistantIdle>());
      expect(controller.state.messages.length, 2);
    });
  });
}

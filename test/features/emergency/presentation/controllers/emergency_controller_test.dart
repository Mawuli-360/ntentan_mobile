import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ntentan/core/constants/enums.dart';
import 'package:ntentan/features/emergency/data/medical_alert_rest_service.dart';
import 'package:ntentan/features/emergency/data/medical_alert_response.dart';
import 'package:ntentan/features/emergency/presentation/controllers/emergency_controller.dart';
import 'package:ntentan/features/emergency/presentation/state/emergency_state.dart';

class MockMedicalAlertRestService extends Mock implements MedicalAlertRestService {}

void main() {
  late EmergencyController controller;
  late MockMedicalAlertRestService mockRestService;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() {
    dotenv.testLoad(fileInput: '''
API_BASE_URL=https://test.com
''');
    mockRestService = MockMedicalAlertRestService();
    controller = EmergencyController(alertRestService: mockRestService);
  });

  group('SOS Flow', () {
    test('activateSOS should transition to counting down', () {
      controller.activateSOS(SosTrigger.button);

      expect(controller.state, isA<EmergencyCountingDown>());
      final state = controller.state as EmergencyCountingDown;
      expect(state.countdown, 5);
      expect(state.lastTrigger, SosTrigger.button);
    });

    test('updateCountdown should decrement and trigger alert at 0', () async {
      when(() => mockRestService.sendAlert(
            baseUrl: any(named: 'baseUrl'),
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
          )).thenAnswer((_) async => MedicalAlertResponse(status: 'success', notifiedContacts: [NotifiedContact(name: 'Wife', phoneNumber: '123', success: true)]));

      controller.activateSOS(SosTrigger.button);
      controller.updateCountdown(4);
      
      var state = controller.state as EmergencyCountingDown;
      expect(state.countdown, 4);

      // Trigger 0
      controller.updateCountdown(0);
      
      // Geolocator might be slow, but state transitions to sending immediately
      expect(controller.state, isA<EmergencySending>());

      // Wait a bit for async work to finish
      await Future.delayed(const Duration(milliseconds: 100));
      
      expect(controller.state, isA<EmergencySent>());
      final sentState = controller.state as EmergencySent;
      expect(sentState.contactsNotified, true);
    });

    test('cancelSOS should return to idle', () {
      controller.activateSOS(SosTrigger.voice);
      expect(controller.state, isA<EmergencyCountingDown>());

      controller.cancelSOS();
      expect(controller.state, isA<EmergencyIdle>());
    });
    
    test('activateSilentMode should set silentMode to true', () {
      controller.activateSOS(SosTrigger.gesture);
      controller.activateSilentMode();
      
      final state = controller.state as EmergencyCountingDown;
      expect(state.silentMode, true);
    });

    test('startPostEmergency should transition to postEmergency', () {
      controller.startPostEmergency();
      expect(controller.state, isA<EmergencyPostActive>());
    });

    test('confirmSafe should transition to idle', () {
      controller.startPostEmergency();
      controller.confirmSafe();
      expect(controller.state, isA<EmergencyIdle>());
    });
  });
}

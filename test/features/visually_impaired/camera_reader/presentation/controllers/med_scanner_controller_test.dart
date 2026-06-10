import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ntentan/core/services/tts_service.dart';
import 'package:ntentan/features/visually_impaired/camera_reader/data/med_scanner_socket_service.dart';
import 'package:ntentan/features/visually_impaired/camera_reader/data/med_scanner_camera_service.dart';
import 'package:ntentan/features/visually_impaired/camera_reader/presentation/controllers/med_scanner_controller.dart';
import 'package:ntentan/features/visually_impaired/camera_reader/presentation/state/med_scanner_state.dart';

class MockMedScannerSocketService extends Mock implements MedScannerSocketService {}
class MockMedScannerCameraService extends Mock implements MedScannerCameraService {}
class MockTtsService extends Mock implements TtsService {}

void main() {
  late MedScannerController controller;
  late MockMedScannerSocketService mockSocketService;
  late MockMedScannerCameraService mockCameraService;
  late MockTtsService mockTtsService;

  setUpAll(() {
    dotenv.testLoad(fileInput: '''
WEBSOCKET_URL=wss://test.com
''');
  });

  setUp(() {
    mockSocketService = MockMedScannerSocketService();
    mockCameraService = MockMedScannerCameraService();
    mockTtsService = MockTtsService();

    // Stub streams
    when(() => mockSocketService.responseStream).thenAnswer((_) => const Stream.empty());

    controller = MedScannerController(
      socketService: mockSocketService,
      cameraService: mockCameraService,
      ttsService: mockTtsService,
    );
  });

  group('Initialization', () {
    test('initCameraAndService should set idle with camera ready on success', () async {
      when(() => mockCameraService.initializeCamera()).thenAnswer((_) async => true);

      await controller.initCameraAndService();

      expect(controller.state, isA<MedScannerIdle>());
      expect(controller.state.isCameraReady, true);
    });

    test('initCameraAndService should set error on failure', () async {
      when(() => mockCameraService.initializeCamera()).thenAnswer((_) async => false);

      await controller.initCameraAndService();

      expect(controller.state, isA<MedScannerError>());
      expect(controller.state.isCameraReady, false);
    });
  });

  group('Scanning Operations', () {
    test('stopScanning should transition to idle', () async {
      when(() => mockCameraService.initializeCamera()).thenAnswer((_) async => true);
      await controller.initCameraAndService();

      when(() => mockCameraService.stopFrameStream()).thenReturn(null);
      when(() => mockSocketService.disconnect()).thenReturn(null);

      // Artificially change state to simulate scanning
      // Since startScanning requires token manager which accesses storage, we just test the stop logic
      controller.updateState(const MedScannerState.scanning(isCameraReady: true, guidanceText: ''));

      controller.stopScanning();

      expect(controller.state, isA<MedScannerIdle>());
      verify(() => mockCameraService.stopFrameStream()).called(1);
      verify(() => mockSocketService.disconnect()).called(1);
    });
  });

  group('Flash', () {
    test('toggleFlash should update state if successful', () async {
      when(() => mockCameraService.initializeCamera()).thenAnswer((_) async => true);
      await controller.initCameraAndService();

      expect(controller.state.isFlashOn, false);

      when(() => mockCameraService.toggleFlash(true)).thenAnswer((_) async => true);

      await controller.toggleFlash();

      expect(controller.state.isFlashOn, true);
    });
  });
}

import 'package:get_it/get_it.dart';
import 'package:ntentan/features/visually_impaired/camera_reader/data/med_scanner_camera_service.dart';
import 'package:ntentan/features/visually_impaired/camera_reader/data/med_scanner_socket_service.dart';
import 'package:ntentan/features/visually_impaired/camera_reader/presentation/controllers/med_scanner_controller.dart';

void initCameraReaderDependencies(GetIt sl) {
  // Service (Singleton, reused across sessions)
  sl.registerLazySingleton<MedScannerSocketService>(
    () => MedScannerSocketService(),
  );

  sl.registerLazySingleton<MedScannerCameraService>(
    () => MedScannerCameraService(),
  );

  // Controller (Factory, new instance per screen to manage local camera lifecycle)
  sl.registerFactory<MedScannerController>(
    () => MedScannerController(
      socketService: sl(),
      cameraService: sl(),
      ttsService: sl(),
    ),
  );
}

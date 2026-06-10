import 'package:get_it/get_it.dart';
import 'package:ntentan/core/utils/storage/shared_prefs_storage.dart';
import 'package:ntentan/core/services/session_lifecycle_service.dart';
import 'package:ntentan/core/utils/storage/secure_storage.dart';
import 'package:ntentan/core/db/app_database.dart';
import 'package:ntentan/core/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ntentan/features/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:ntentan/features/emergency/presentation/controllers/emergency_controller.dart';
import 'package:ntentan/features/auth/auth_injection.dart';
import 'package:ntentan/features/settings/settings_injection.dart';
import 'package:ntentan/features/visually_impaired/camera_reader/camera_reader_injection.dart';
import 'package:ntentan/features/visually_impaired/voice_assistant/voice_assistant_injection.dart';
import 'package:ntentan/core/services/accessibility/accessibility_service_locator.dart';
import 'package:ntentan/features/emergency/data/medical_alert_rest_service.dart';
import 'package:ntentan/core/services/tts_service.dart';

final sl = GetIt.instance;

/// Register all dependencies with GetIt.
/// Order: External → Core Utils → Feature Modules → Controllers
Future<void> initDependencies() async {
  // ── External ──
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  const secureStorage = FlutterSecureStorage();
  sl.registerSingleton<FlutterSecureStorage>(secureStorage);

  final db = AppDatabase();
  sl.registerSingleton<AppDatabase>(db);

  sl.registerSingleton<SessionLifecycleService>(SessionLifecycleService());

  sl.registerLazySingleton<NotificationService>(
    () => NotificationService(
      profileRepository: sl(),
      medicationRepository: sl(),
    ),
  );

  // ── Core Utils ──
  sl.registerLazySingleton<SharedPrefsStorage>(
      () => SharedPrefsStorage(prefs: sl()));

  sl.registerLazySingleton<SecureStorage>(() => SecureStorage(storage: sl()));

  sl.registerLazySingleton<TtsService>(() => TtsService());

  // ── Accessibility Services ──
  initAccessibilityServices(sl);
  await initAccessibilityAsync(sl);
  await sl<TtsService>().init();

  // ── Feature Modules ──
  initAuthDependencies(sl);
  initSettingsDependencies(sl);
  initCameraReaderDependencies(sl);
  initVoiceAssistantDependencies(sl);

  // ── Shared Controllers ──
  sl.registerLazySingleton<MedicalAlertRestService>(() => MedicalAlertRestService());
  sl.registerLazySingleton<DashboardController>(() => DashboardController());
  sl.registerLazySingleton<EmergencyController>(() => EmergencyController(alertRestService: sl()));

  // ── Session Registration ──
  final lifecycleService = sl<SessionLifecycleService>();
  lifecycleService.register(sl<DashboardController>(), priority: 60);
}

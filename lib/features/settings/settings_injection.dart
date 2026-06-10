import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:ntentan/core/services/session_lifecycle_service.dart';
import 'package:ntentan/features/settings/data/datasources/medication_local_data_source.dart';
import 'package:ntentan/features/settings/data/datasources/medication_remote_data_source.dart';
import 'package:ntentan/features/settings/data/repositories/medication_repository_impl.dart';
import 'package:ntentan/features/settings/domain/repositories/medication_repository.dart';
import 'package:ntentan/features/settings/presentation/controllers/medication_controller.dart';
import 'package:ntentan/features/settings/presentation/controllers/accessibility_controller.dart';

void initSettingsDependencies(GetIt sl) {
  // ── Data Sources ──
  sl.registerLazySingleton<MedicationLocalDataSource>(
    () => MedicationLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<MedicationRemoteDataSource>(
    () => MedicationRemoteDataSourceImpl(FirebaseFirestore.instance),
  );

  // ── Repository ──
  sl.registerLazySingleton<MedicationRepository>(
    () => MedicationRepositoryImpl(sl(), sl()),
  );

  // ── Controller ──
  sl.registerLazySingleton<MedicationController>(
    () => MedicationController(sl(), sl()),
  );
  sl.registerLazySingleton<AccessibilityController>(
    () => AccessibilityController(
      profileRepository: sl(),
      notificationService: sl(),
    ),
  );

  // ── Session Registration ──
  final lifecycleService = sl<SessionLifecycleService>();

  // Repository handles remote sync (priority 75 — before controller)
  lifecycleService.register(
    sl<MedicationRepository>() as SessionLifecycleHandler,
    priority: 75,
  );

  // Controller loads data after repository is synced (priority 80)
  lifecycleService.register(
    sl<MedicationController>(),
    priority: 80,
  );

  lifecycleService.register(
    sl<AccessibilityController>(),
    priority: 85,
  );
}

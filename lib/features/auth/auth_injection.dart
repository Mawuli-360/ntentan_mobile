import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ntentan/features/auth/data/datasources/profile_local_data_source.dart';
import 'package:ntentan/features/auth/data/datasources/profile_remote_data_source.dart';
import 'package:ntentan/features/auth/data/repositories/profile_repository_impl.dart';
import 'package:ntentan/features/auth/domain/repositories/profile_repository.dart';
import 'package:ntentan/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ntentan/features/auth/domain/repositories/auth_repository.dart';
import 'package:ntentan/features/auth/presentation/controllers/auth_controller.dart';
import 'package:ntentan/core/services/session_lifecycle_service.dart';

import 'package:ntentan/features/auth/presentation/controllers/profile_controller.dart';

void initAuthDependencies(GetIt sl) {
  // ── Data Sources ──
  sl.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(FirebaseFirestore.instance),
  );

  // ── Repositories ──
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl(), sl()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authClient: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
      secureStorage: sl(),
      sharedPrefsStorage: sl(),
      profileLocalDataSource: sl(),
      lifecycleService: sl(),
    ),
  );

  // ── Controllers ──
  sl.registerFactory<AuthController>(() => AuthController(sl(), sl()));
  
  sl.registerLazySingleton<ProfileController>(
    () => ProfileController(sl(), sl()),
  );

  // ── Session Registration ──
  final lifecycleService = sl<SessionLifecycleService>();
  lifecycleService.register(
    sl<ProfileRepository>() as SessionLifecycleHandler,
    priority: 10,
  );
  
  lifecycleService.register(
    sl<ProfileController>(),
    priority: 50,
  );
}

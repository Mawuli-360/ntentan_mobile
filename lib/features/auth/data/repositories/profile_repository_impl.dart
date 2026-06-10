import 'dart:async';
import 'package:fpdart/fpdart.dart';
import 'package:ntentan/core/constants/logger.dart';
import 'package:ntentan/core/exception/failure.dart';
import 'package:ntentan/core/utils/custom_types.dart';
import 'package:ntentan/features/auth/data/datasources/profile_local_data_source.dart';
import 'package:ntentan/features/auth/data/datasources/profile_remote_data_source.dart';
import 'package:ntentan/features/auth/domain/entities/user_entity.dart';
import 'package:ntentan/features/auth/domain/repositories/profile_repository.dart';
import 'package:ntentan/core/services/session_lifecycle_service.dart';

class ProfileRepositoryImpl implements ProfileRepository, SessionLifecycleHandler {
  final ProfileLocalDataSource _localDataSource;
  final ProfileRemoteDataSource _remoteDataSource;
  StreamSubscription? _remoteSyncSubscription;

  ProfileRepositoryImpl(this._localDataSource, this._remoteDataSource);

  @override
  FutureVoid saveProfile(UserEntity profile) async {
    // 1. Always save locally first so offline features still work
    final localResult = await _localDataSource.saveProfile(profile);

    // 2. If it fails locally, bail out early
    if (localResult.isLeft()) return localResult;

    // 3. Sync to remote Firestore if the user is authenticated (has uid)
    if (profile.uid != null && profile.uid!.isNotEmpty) {
      final remoteResult = await _remoteDataSource.saveProfile(profile);
      if (remoteResult.isLeft()) return remoteResult;
    }

    return const Right(unit);
  }

  @override
  FutureEither<UserEntity?> getProfile() => _localDataSource.getProfile();

  @override
  Stream<Either<Failure, UserEntity?>> watchProfile() =>
      _localDataSource.watchProfile();

  @override
  FutureVoid clearProfile() async {
    stopRemoteSync();
    return _localDataSource.clearProfile();
  }

  @override
  void startRemoteSync(String uid) {
    _remoteSyncSubscription?.cancel();
    _remoteSyncSubscription = _remoteDataSource.watchProfile(uid).listen(
      (remoteResult) {
        remoteResult.fold(
          (failure) =>
              AppLogger.e('Remote Profile Sync Error: ${failure.message}'),
          (profile) {
            if (profile != null) {
              _localDataSource.saveProfile(profile);
            }
          },
        );
      },
    );
  }

  @override
  void stopRemoteSync() {
    _remoteSyncSubscription?.cancel();
    _remoteSyncSubscription = null;
  }

  @override
  FutureEither<UserEntity?> fetchProfileFromRemote(String uid) async {
    final remoteResult = await _remoteDataSource.getProfile(uid);

    if (remoteResult.isRight()) {
      final profile = remoteResult.getOrElse((_) => null);
      if (profile != null) {
        // Hydrate local cache and await completion
        await _localDataSource.saveProfile(profile);
      }
    }
    return remoteResult;
  }

  // ── SessionLifecycleHandler ──

  @override
  Future<void> onSessionStarted(String userId) async {
    AppLogger.i('ProfileRepository: hydrating session for user $userId');
    startRemoteSync(userId);
    await fetchProfileFromRemote(userId);
  }

  @override
  Future<void> onSessionEnded() async {
    AppLogger.i('ProfileRepository: clearing session data');
    await clearProfile();
  }

  @override
  Future<void> onAccountDeleted(String userId) async {
    AppLogger.i('ProfileRepository: purging all data for $userId');
    stopRemoteSync();
    await Future.wait([
      _remoteDataSource.deleteProfile(userId),
      _localDataSource.clearProfile(),
    ]);
  }
}

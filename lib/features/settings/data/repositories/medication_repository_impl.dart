import 'dart:async';
import 'package:fpdart/fpdart.dart';
import 'package:ntentan/core/constants/logger.dart';
import 'package:ntentan/core/exception/failure.dart';
import 'package:ntentan/core/services/session_lifecycle_service.dart';
import 'package:ntentan/core/utils/custom_types.dart';
import 'package:ntentan/features/settings/data/datasources/medication_local_data_source.dart';
import 'package:ntentan/features/settings/data/datasources/medication_remote_data_source.dart';
import 'package:ntentan/features/settings/domain/entities/medication.dart';
import 'package:ntentan/features/settings/domain/repositories/medication_repository.dart';

/// Offline-first repository implementation:
/// - Reads from local DB immediately.
/// - Writes to local DB first, then syncs to Firestore in background.
/// - Listens to Firestore stream and keeps local cache in sync.
class MedicationRepositoryImpl
    implements MedicationRepository, SessionLifecycleHandler {
  final MedicationLocalDataSource _local;
  final MedicationRemoteDataSource _remote;
  StreamSubscription<Either<Failure, List<Medication>>>?
      _remoteSyncSubscription;

  MedicationRepositoryImpl(this._local, this._remote);

  // ── Read ─────────────────────────────────────────────────────────────────────

  @override
  FutureEither<List<Medication>> fetchMedications(String uid) =>
      _local.getMedications(uid);

  @override
  Stream<Either<Failure, List<Medication>>> watchMedications(String uid) =>
      _local.watchMedications(uid);

  // ── Write ─────────────────────────────────────────────────────────────────────

  @override
  FutureVoid saveMedication(String uid, Medication medication) async {
    // 1. Write locally first
    final localResult = await _local.saveMedication(uid, medication);
    if (localResult.isLeft()) return localResult;

    // 2. Sync to Firestore in background (don't block UI)
    _remote.saveMedication(uid, medication).then((result) {
      result.fold(
        (failure) => AppLogger.e('Remote save failed: ${failure.message}'),
        (_) => AppLogger.i('Medication synced to Firestore: ${medication.id}'),
      );
    });

    return const Right(unit);
  }

  @override
  FutureVoid updateMedication(String uid, Medication medication) async {
    final localResult = await _local.updateMedication(uid, medication);
    if (localResult.isLeft()) return localResult;

    _remote.updateMedication(uid, medication).then((result) {
      result.fold(
        (failure) => AppLogger.e('Remote update failed: ${failure.message}'),
        (_) => AppLogger.i('Medication updated on Firestore: ${medication.id}'),
      );
    });

    return const Right(unit);
  }

  @override
  FutureVoid deleteMedication(String uid, String medicationId) async {
    final localResult = await _local.deleteMedication(uid, medicationId);
    if (localResult.isLeft()) return localResult;

    _remote.deleteMedication(uid, medicationId).then((result) {
      result.fold(
        (failure) => AppLogger.e('Remote delete failed: ${failure.message}'),
        (_) =>
            AppLogger.i('Medication deleted from Firestore: $medicationId'),
      );
    });

    return const Right(unit);
  }

  // ── Remote Sync ───────────────────────────────────────────────────────────────

  void startRemoteSync(String uid) {
    _remoteSyncSubscription?.cancel();
    _remoteSyncSubscription = _remote.watchMedications(uid).listen(
      (result) {
        result.fold(
          (failure) =>
              AppLogger.e('Remote medication sync error: ${failure.message}'),
          (remoteMeds) async {
            // Update local cache with latest from Firestore, respecting updatedAt
            final localResult = await _local.getMedications(uid);
            final localMeds = localResult.getOrElse((_) => []);
            
            for (final remoteMed in remoteMeds) {
              final localMed = localMeds.cast<Medication?>().firstWhere(
                (m) => m?.id == remoteMed.id,
                orElse: () => null,
              );

              // Only update if local doesn't exist, OR remote is strictly newer, 
              // OR both are legacy (null updatedAt) and we need to sync.
              final shouldUpdate = localMed == null || 
                  (remoteMed.updatedAt != null && 
                   (localMed.updatedAt == null || remoteMed.updatedAt!.isAfter(localMed.updatedAt!))) ||
                  (remoteMed.updatedAt == null && localMed.updatedAt == null);

              if (shouldUpdate) {
                _local.saveMedication(uid, remoteMed);
              }
            }
          },
        );
      },
    );
  }

  void stopRemoteSync() {
    _remoteSyncSubscription?.cancel();
    _remoteSyncSubscription = null;
  }

  // ── SessionLifecycleHandler ───────────────────────────────────────────────────

  @override
  Future<void> onSessionStarted(String userId) async {
    AppLogger.i('MedicationRepository: starting sync for $userId');
    startRemoteSync(userId);
  }

  @override
  Future<void> onSessionEnded() async {
    AppLogger.i('MedicationRepository: clearing session medications');
    stopRemoteSync();
  }

  @override
  Future<void> onAccountDeleted(String userId) async {
    AppLogger.i('MedicationRepository: purging all data for $userId');
    stopRemoteSync();
    await Future.wait([
      _remote.deleteAllMedications(userId),
      _local.clearMedications(userId),
    ]);
  }
}

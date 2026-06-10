import 'package:fpdart/fpdart.dart';
import 'package:ntentan/core/exception/failure.dart';
import 'package:ntentan/core/utils/custom_types.dart';
import 'package:ntentan/features/settings/domain/entities/medication.dart';

/// Contract for persisting and fetching [Medication] records.
///
/// Implementations should follow an **offline-first** strategy:
/// write to local cache immediately, and sync to remote in the background.
abstract class MedicationRepository {
  /// Fetch all medications for [uid] from the local cache.
  FutureEither<List<Medication>> fetchMedications(String uid);

  /// Add or update a single medication (both locally and remotely).
  FutureVoid saveMedication(String uid, Medication medication);

  /// Update an existing medication record.
  FutureVoid updateMedication(String uid, Medication medication);

  /// Delete a medication by its [medicationId].
  FutureVoid deleteMedication(String uid, String medicationId);

  /// Real-time stream of the user's medications from Firestore.
  Stream<Either<Failure, List<Medication>>> watchMedications(String uid);
}

import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ntentan/core/db/app_database.dart';
import 'package:ntentan/core/exception/failure.dart';
import 'package:ntentan/core/utils/custom_types.dart';
import 'package:ntentan/features/settings/domain/entities/medication.dart';

/// Contract for local medication persistence using [AppDatabase].
abstract class MedicationLocalDataSource {
  FutureEither<List<Medication>> getMedications(String uid);
  FutureVoid saveMedication(String uid, Medication medication);
  FutureVoid updateMedication(String uid, Medication medication);
  FutureVoid deleteMedication(String uid, String medicationId);
  FutureVoid clearMedications(String uid);
  Stream<Either<Failure, List<Medication>>> watchMedications(String uid);
}

class MedicationLocalDataSourceImpl implements MedicationLocalDataSource {
  final AppDatabase _db;

  MedicationLocalDataSourceImpl(this._db);

  // ── Helpers ─────────────────────────────────────────────────────────────────

  Medication _fromJson(String json) {
    final data = jsonDecode(json) as Map<String, dynamic>;
    if (data['completedSlots'] is List) {
      final Map<String, dynamic> newCompletedSlots = {};
      for (final item in (data['completedSlots'] as List)) {
        newCompletedSlots[item.toString()] = DateTime.now().toIso8601String();
      }
      data['completedSlots'] = newCompletedSlots;
    }
    return Medication.fromJson(data);
  }

  // ── Read ─────────────────────────────────────────────────────────────────────

  @override
  FutureEither<List<Medication>> getMedications(String uid) async {
    try {
      final rows = await (_db.select(_db.medicationCache)
            ..where((t) => t.ownerUid.equals(uid)))
          .get();
      return right(rows.map((r) => _fromJson(r.data)).toList());
    } catch (e) {
      return left(Failure.cache(message: 'Failed to load medications locally'));
    }
  }

  @override
  Stream<Either<Failure, List<Medication>>> watchMedications(String uid) {
    final query = _db.select(_db.medicationCache)
      ..where((t) => t.ownerUid.equals(uid));
    return query
        .watch()
        .map<Either<Failure, List<Medication>>>(
          (rows) => right(rows.map((r) => _fromJson(r.data)).toList()),
        )
        .handleError((Object e) => left<Failure, List<Medication>>(
            Failure.cache(message: 'Failed to watch medications: $e')));
  }

  // ── Write ────────────────────────────────────────────────────────────────────

  @override
  FutureVoid saveMedication(String uid, Medication medication) async {
    try {
      await _db.into(_db.medicationCache).insertOnConflictUpdate(
            MedicationCacheCompanion.insert(
              id: medication.id,
              ownerUid: uid,
              data: jsonEncode(medication.toJson()),
            ),
          );
      return const Right(unit);
    } catch (e) {
      return left(Failure.cache(message: 'Failed to save medication locally'));
    }
  }

  @override
  FutureVoid updateMedication(String uid, Medication medication) =>
      saveMedication(uid, medication); // upsert handles update

  @override
  FutureVoid deleteMedication(String uid, String medicationId) async {
    try {
      await (_db.delete(_db.medicationCache)
            ..where(
                (t) => t.id.equals(medicationId) & t.ownerUid.equals(uid)))
          .go();
      return const Right(unit);
    } catch (e) {
      return left(
          Failure.cache(message: 'Failed to delete medication locally'));
    }
  }

  @override
  FutureVoid clearMedications(String uid) async {
    try {
      await (_db.delete(_db.medicationCache)
            ..where((t) => t.ownerUid.equals(uid)))
          .go();
      return const Right(unit);
    } catch (e) {
      return left(
          Failure.cache(message: 'Failed to clear medications locally'));
    }
  }
}

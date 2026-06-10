import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ntentan/core/constants/logger.dart';
import 'package:ntentan/core/exception/failure.dart';
import 'package:ntentan/core/utils/custom_types.dart';
import 'package:ntentan/features/settings/domain/entities/medication.dart';

/// Contract for Firestore medication persistence.
abstract class MedicationRemoteDataSource {
  FutureEither<List<Medication>> getMedications(String uid);
  FutureVoid saveMedication(String uid, Medication medication);
  FutureVoid updateMedication(String uid, Medication medication);
  FutureVoid deleteMedication(String uid, String medicationId);
  FutureVoid deleteAllMedications(String uid);
  Stream<Either<Failure, List<Medication>>> watchMedications(String uid);
}

class MedicationRemoteDataSourceImpl implements MedicationRemoteDataSource {
  final FirebaseFirestore _firestore;

  MedicationRemoteDataSourceImpl(this._firestore);

  // ── Collection reference ─────────────────────────────────────────────────────
  /// Path: users/{uid}/medications
  CollectionReference<Map<String, dynamic>> _medicationsRef(String uid) =>
      _firestore.collection('users').doc(uid).collection('medications');

  // ── Helpers ──────────────────────────────────────────────────────────────────

  Map<String, dynamic> _toFirestoreMap(Medication med) {
    final map = med.toJson();
    // Ensure timestamps are correctly represented in Firestore as strings/ISO8601
    // or let json_serializable do it.
    return map;
  }

  Medication _fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = Map<String, dynamic>.from(doc.data()!);
    data['id'] ??= doc.id;

    // --- LEGACY DATA MIGRATION ---
    // 1. Map 'timeSlot' (singular) to 'timeSlots' (plural)
    if (data['timeSlots'] == null && data['timeSlot'] != null) {
      data['timeSlots'] = [data['timeSlot']];
    }
    // 2. Map 'taken' (bool) to 'completedSlots' (map)
    if (data['completedSlots'] == null) {
      if (data['taken'] == true && data['timeSlot'] != null) {
        data['completedSlots'] = {
          data['timeSlot'].toString(): DateTime.now().toIso8601String()
        };
      } else {
        data['completedSlots'] = <String, dynamic>{};
      }
    } else if (data['completedSlots'] is List) {
      // Migrate array of strings/enums to Map
      final Map<String, dynamic> newCompletedSlots = {};
      for (final item in (data['completedSlots'] as List)) {
        newCompletedSlots[item.toString()] = DateTime.now().toIso8601String();
      }
      data['completedSlots'] = newCompletedSlots;
    }
    // 3. Defaults for new required fields
    data['unitsPerDose'] ??= 1;
    data['frequency'] ??= data['timeSlots']?.length ?? 1;
    data['instruction'] ??= '';
    data['dosage'] ??= '';

    return Medication.fromJson(data);
  }

  // ── Read ─────────────────────────────────────────────────────────────────────

  @override
  FutureEither<List<Medication>> getMedications(String uid) async {
    try {
      final snapshot = await _medicationsRef(uid).get();
      final meds = snapshot.docs.map(_fromDoc).toList();
      return right(meds);
    } on FirebaseException catch (e) {
      AppLogger.e('getMedications FirebaseException: ${e.code}');
      return left(Failure.network(message: e.message ?? 'Failed to fetch medications'));
    } catch (e) {
      return left(Failure.unexpected(message: 'Unexpected error fetching medications'));
    }
  }

  @override
  Stream<Either<Failure, List<Medication>>> watchMedications(String uid) {
    return _medicationsRef(uid)
        .snapshots()
        .map<Either<Failure, List<Medication>>>(
          (snapshot) => right(snapshot.docs.map(_fromDoc).toList()),
        )
        .handleError((Object e) {
      if (e is FirebaseException) {
        return left<Failure, List<Medication>>(
            Failure.network(message: e.message ?? 'Firestore stream error'));
      }
      return left<Failure, List<Medication>>(
          Failure.unexpected(message: 'Unexpected stream error'));
    });
  }

  // ── Write ─────────────────────────────────────────────────────────────────────

  @override
  FutureVoid saveMedication(String uid, Medication medication) async {
    try {
      await _medicationsRef(uid)
          .doc(medication.id)
          .set(_toFirestoreMap(medication), SetOptions(merge: true));
      return const Right(unit);
    } on FirebaseException catch (e) {
      AppLogger.e('saveMedication FirebaseException: ${e.code}');
      return left(Failure.network(message: e.message ?? 'Failed to save medication'));
    } catch (e) {
      return left(Failure.unexpected(message: 'Unexpected error saving medication'));
    }
  }

  @override
  FutureVoid updateMedication(String uid, Medication medication) async {
    try {
      await _medicationsRef(uid)
          .doc(medication.id)
          .update(_toFirestoreMap(medication));
      return const Right(unit);
    } on FirebaseException catch (e) {
      AppLogger.e('updateMedication FirebaseException: ${e.code}');
      return left(Failure.network(message: e.message ?? 'Failed to update medication'));
    } catch (e) {
      return left(Failure.unexpected(message: 'Unexpected error updating medication'));
    }
  }

  @override
  FutureVoid deleteMedication(String uid, String medicationId) async {
    try {
      await _medicationsRef(uid).doc(medicationId).delete();
      return const Right(unit);
    } on FirebaseException catch (e) {
      AppLogger.e('deleteMedication FirebaseException: ${e.code}');
      return left(
          Failure.network(message: e.message ?? 'Failed to delete medication'));
    } catch (e) {
      return left(
          Failure.unexpected(message: 'Unexpected error deleting medication'));
    }
  }

  @override
  FutureVoid deleteAllMedications(String uid) async {
    try {
      final snapshot = await _medicationsRef(uid).get();
      final batch = _firestore.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
      return const Right(unit);
    } on FirebaseException catch (e) {
      AppLogger.e('deleteAllMedications FirebaseException: ${e.code}');
      return left(
          Failure.network(message: e.message ?? 'Failed to delete medications'));
    } catch (e) {
      return left(
          Failure.unexpected(message: 'Unexpected error deleting medications'));
    }
  }
}

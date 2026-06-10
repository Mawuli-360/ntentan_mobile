import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ntentan/core/constants/logger.dart';
import 'package:ntentan/core/exception/failure.dart';
import 'package:ntentan/core/utils/custom_types.dart';
import 'package:ntentan/features/auth/domain/entities/user_entity.dart';

abstract class ProfileRemoteDataSource {
  /// Push the full user profile to Firestore. Requires [uid].
  FutureVoid saveProfile(UserEntity profile);

  /// Fetch the user's profile document from Firestore by [uid].
  FutureEither<UserEntity?> getProfile(String uid);

  /// Watch real-time profile changes from Firestore.
  Stream<Either<Failure, UserEntity?>> watchProfile(String uid);

  /// Hard-delete the Firestore document (e.g. account deletion).
  FutureVoid deleteProfile(String uid);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirebaseFirestore _firestore;

  // ── Collection reference ──────────────────────────────────────────────────
  static const String _collection = 'users';

  ProfileRemoteDataSourceImpl(this._firestore);

  CollectionReference<Map<String, dynamic>> get _usersRef =>
      _firestore.collection(_collection);

  // ── Helpers ───────────────────────────────────────────────────────────────

  /// Converts a [UserEntity] to a Firestore-safe map.
  /// Timestamps are stored as ISO 8601 strings for cross-platform compatibility.
  Map<String, dynamic> _toFirestoreMap(UserEntity profile) {
    final map = profile.toJson();
    // Overwrite updatedAt on every write
    map['updatedAt'] = DateTime.now().toIso8601String();
    // Ensure createdAt is only set once (keep original if present)
    map['createdAt'] ??= DateTime.now().toIso8601String();
    return map;
  }

  UserEntity _fromFirestoreDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    // Inject the Firestore document ID as uid if not already present
    data['uid'] ??= doc.id;
    return UserEntity.fromJson(data);
  }

  // ── Implementation ────────────────────────────────────────────────────────

  @override
  FutureVoid saveProfile(UserEntity profile) async {
    try {
      if (profile.uid == null || profile.uid!.isEmpty) {
        return Left<Failure, Unit>(
            Failure.cache(message: 'Cannot save profile: uid is null'));
      }
      await _usersRef
          .doc(profile.uid)
          .set(_toFirestoreMap(profile), SetOptions(merge: true));
      return Right<Failure, Unit>(unit);
    } on FirebaseException catch (e) {
      AppLogger.e('saveProfile FirebaseException: ${e.code} — ${e.message}');
      return Left<Failure, Unit>(
          Failure.network(message: e.message ?? 'Firestore write failed'));
    } catch (e, st) {
      AppLogger.e('saveProfile unexpected: $e\n$st');
      return Left<Failure, Unit>(
          Failure.unexpected(message: 'Unexpected error saving profile: $e'));
    }
  }

  @override
  FutureEither<UserEntity?> getProfile(String uid) async {
    try {
      final doc = await _usersRef.doc(uid).get();
      if (!doc.exists || doc.data() == null) return right(null);
      return right(_fromFirestoreDoc(doc));
    } on FirebaseException catch (e) {
      return left(
          Failure.network(message: e.message ?? 'Firestore read failed'));
    } catch (e) {
      return left(Failure.unexpected(message: 'Unexpected error reading profile'));
    }
  }

  @override
  Stream<Either<Failure, UserEntity?>> watchProfile(String uid) {
    return _usersRef.doc(uid).snapshots().map<Either<Failure, UserEntity?>>((doc) {
      if (!doc.exists || doc.data() == null) return const Right(null);
      return Right<Failure, UserEntity?>(_fromFirestoreDoc(doc));
    }).handleError((Object e, StackTrace s) {
      if (e is FirebaseException) {
        return Left<Failure, UserEntity?>(
            Failure.network(message: e.message ?? 'Firestore stream error'));
      }
      return Left<Failure, UserEntity?>(
          Failure.unexpected(message: 'Unexpected stream error'));
    });
  }

  @override
  FutureVoid deleteProfile(String uid) async {
    try {
      await _usersRef.doc(uid).delete();
      return Right<Failure, Unit>(unit);
    } on FirebaseException catch (e) {
      return Left<Failure, Unit>(
          Failure.network(message: e.message ?? 'Firestore delete failed'));
    } catch (e) {
      return Left<Failure, Unit>(
          Failure.unexpected(message: 'Unexpected error deleting profile'));
    }
  }
}

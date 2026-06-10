import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:ntentan/core/db/app_database.dart';
import 'package:ntentan/core/exception/failure.dart';
import 'package:ntentan/core/utils/custom_types.dart';
import 'package:drift/drift.dart';
import 'package:ntentan/features/auth/domain/entities/user_entity.dart';

abstract class ProfileLocalDataSource {
  FutureVoid saveProfile(UserEntity profile);
  FutureEither<UserEntity?> getProfile();
  Stream<Either<Failure, UserEntity?>> watchProfile();
  FutureVoid clearProfile();
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final AppDatabase _db;

  ProfileLocalDataSourceImpl(this._db);

  static const String _localUid = 'local_user';

  @override
  FutureVoid saveProfile(UserEntity profile) async {
    try {
      final jsonString = jsonEncode(profile.toJson());
      
      final query = _db.select(_db.userProfiles)..where((t) => t.uid.equals(_localUid));
      final existing = await query.getSingleOrNull();

      if (existing != null) {
        await (_db.update(_db.userProfiles)..where((t) => t.uid.equals(_localUid))).write(
          UserProfilesCompanion(profileJson: Value(jsonString)),
        );
      } else {
        await _db.into(_db.userProfiles).insert(
          UserProfilesCompanion.insert(uid: _localUid, profileJson: jsonString),
        );
      }
      
      return const Right<Failure, Unit>(unit);
    } catch (e) {
      return Left<Failure, Unit>(
          Failure.cache(message: 'Failed to save profile locally'));
    }
  }

  @override
  FutureEither<UserEntity?> getProfile() async {
    try {
      final query = _db.select(_db.userProfiles)
        ..where((t) => t.uid.equals(_localUid));
      final record = await query.getSingleOrNull();

      if (record == null || record.profileJson.isEmpty) {
        return const Right(null);
      }

      final jsonMap = jsonDecode(record.profileJson) as Map<String, dynamic>;
      return Right(UserEntity.fromJson(jsonMap));
    } catch (e) {
      return Left(Failure.cache(message: 'Failed to read profile locally'));
    }
  }

  @override
  Stream<Either<Failure, UserEntity?>> watchProfile() {
    final query = _db.select(_db.userProfiles)
      ..where((t) => t.uid.equals(_localUid));

    return query.watchSingleOrNull().map<Either<Failure, UserEntity?>>((record) {
      if (record == null || record.profileJson.isEmpty) {
        return const Right(null);
      }
      final jsonMap = jsonDecode(record.profileJson) as Map<String, dynamic>;
      return Right(UserEntity.fromJson(jsonMap));
    }).handleError((Object error, StackTrace stackTrace) {
      return Left<Failure, UserEntity?>(
          Failure.cache(message: 'Failed to watch profile locally stream: $error'));
    });
  }

  @override
  FutureVoid clearProfile() async {
    try {
      await (_db.delete(_db.userProfiles)..where((t) => t.uid.equals(_localUid))).go();
      return const Right<Failure, Unit>(unit);
    } catch (e) {
      return Left<Failure, Unit>(
          Failure.cache(message: 'Failed to clear profile locally'));
    }
  }
}

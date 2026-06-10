import 'package:ntentan/core/utils/custom_types.dart';
import 'package:ntentan/features/auth/domain/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ntentan/core/exception/failure.dart';

abstract class ProfileRepository {
  FutureVoid saveProfile(UserEntity profile);
  FutureEither<UserEntity?> getProfile();
  Stream<Either<Failure, UserEntity?>> watchProfile();
  FutureVoid clearProfile();
  void startRemoteSync(String uid);
  void stopRemoteSync();
  FutureEither<UserEntity?> fetchProfileFromRemote(String uid);
}

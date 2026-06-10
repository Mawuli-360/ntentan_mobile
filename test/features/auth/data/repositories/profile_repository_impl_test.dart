import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ntentan/core/exception/failure.dart';
import 'package:ntentan/features/auth/data/datasources/profile_local_data_source.dart';
import 'package:ntentan/features/auth/data/datasources/profile_remote_data_source.dart';
import 'package:ntentan/features/auth/data/repositories/profile_repository_impl.dart';
import 'package:ntentan/features/auth/domain/entities/user_entity.dart';

class MockProfileLocalDataSource extends Mock implements ProfileLocalDataSource {}
class MockProfileRemoteDataSource extends Mock implements ProfileRemoteDataSource {}

void main() {
  setUpAll(() {
    registerFallbackValue(const UserEntity());
  });

  late ProfileRepositoryImpl profileRepository;
  late MockProfileLocalDataSource mockLocalDataSource;
  late MockProfileRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockLocalDataSource = MockProfileLocalDataSource();
    mockRemoteDataSource = MockProfileRemoteDataSource();
    profileRepository = ProfileRepositoryImpl(mockLocalDataSource, mockRemoteDataSource);
  });

  const tUserId = 'test_uid';
  const tUserEntity = UserEntity(uid: tUserId, userName: 'Test User');

  group('saveProfile', () {
    test('should save locally and remotely if local succeeds and user has uid', () async {
      // arrange
      when(() => mockLocalDataSource.saveProfile(tUserEntity)).thenAnswer((_) async => const Right(unit));
      when(() => mockRemoteDataSource.saveProfile(tUserEntity)).thenAnswer((_) async => const Right(unit));

      // act
      final result = await profileRepository.saveProfile(tUserEntity);

      // assert
      expect(result.isRight(), isTrue);
      verify(() => mockLocalDataSource.saveProfile(tUserEntity)).called(1);
      verify(() => mockRemoteDataSource.saveProfile(tUserEntity)).called(1);
    });

    test('should return Failure if local save fails', () async {
      // arrange
      when(() => mockLocalDataSource.saveProfile(tUserEntity))
          .thenAnswer((_) async => left(const Failure.cache(message: 'Local save error')));

      // act
      final result = await profileRepository.saveProfile(tUserEntity);

      // assert
      expect(result.isLeft(), isTrue);
      verify(() => mockLocalDataSource.saveProfile(tUserEntity)).called(1);
      verifyNever(() => mockRemoteDataSource.saveProfile(any()));
    });
  });

  group('getProfile', () {
    test('should return profile from local data source', () async {
      // arrange
      when(() => mockLocalDataSource.getProfile()).thenAnswer((_) async => right(tUserEntity));

      // act
      final result = await profileRepository.getProfile();

      // assert
      expect(result.isRight(), isTrue);
      result.fold((l) => fail('Expected right'), (r) => expect(r, tUserEntity));
      verify(() => mockLocalDataSource.getProfile()).called(1);
    });
  });

  group('fetchProfileFromRemote', () {
    test('should fetch from remote and save to local data source', () async {
      // arrange
      when(() => mockRemoteDataSource.getProfile(tUserId)).thenAnswer((_) async => right(tUserEntity));
      when(() => mockLocalDataSource.saveProfile(tUserEntity)).thenAnswer((_) async => const Right(unit));

      // act
      final result = await profileRepository.fetchProfileFromRemote(tUserId);

      // assert
      expect(result.isRight(), isTrue);
      verify(() => mockRemoteDataSource.getProfile(tUserId)).called(1);
      verify(() => mockLocalDataSource.saveProfile(tUserEntity)).called(1);
    });
  });

  group('onAccountDeleted', () {
    test('should delete from remote and clear local data', () async {
      // arrange
      when(() => mockRemoteDataSource.deleteProfile(tUserId)).thenAnswer((_) async => const Right(unit));
      when(() => mockLocalDataSource.clearProfile()).thenAnswer((_) async => const Right(unit));

      // act
      await profileRepository.onAccountDeleted(tUserId);

      // assert
      verify(() => mockRemoteDataSource.deleteProfile(tUserId)).called(1);
      verify(() => mockLocalDataSource.clearProfile()).called(1);
    });
  });
}

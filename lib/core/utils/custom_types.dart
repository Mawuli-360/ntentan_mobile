import 'package:fpdart/fpdart.dart';
import 'package:ntentan/core/exception/failure.dart';

/// A convenience type alias for `Either<Failure, T>`.

typedef FutureEither<T> = Future<Either<Failure, T>>;

/// Same as [FutureEither] but when the success type is `Unit`.
typedef FutureVoid = FutureEither<Unit>;

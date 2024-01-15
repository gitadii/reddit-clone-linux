import "package:fpdart/fpdart.dart";
import "package:redditclone_linux/core/failure.dart";

// Either can be of type Failure or a type which can be declared later:
typedef FutureEither<T> = Future<Either<Failure, T>>;

// Means if false than Type Failure and if true then type Void
typedef FutureVoid = FutureEither<void>;

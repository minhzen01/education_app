import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failures/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef DataMap = Map<String, dynamic>;

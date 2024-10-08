import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions/cache_exception.dart';
import 'package:education_app/core/errors/failures/cache_failure.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:education_app/src/on_boarding/domain/repositories/on_boarding_repository.dart';

class OnBoardingRepositoryImpl implements OnBoardingRepository {
  const OnBoardingRepositoryImpl(
    this._localDataSource,
  );

  final OnBoardingLocalDataSource _localDataSource;

  @override
  ResultFuture<void> cacheFirstTimer() async {
    try {
      await _localDataSource.cacheFirstTimer();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(
        CacheFailure(
          statusCode: e.statusCode,
          message: e.message,
        ),
      );
    }
  }

  @override
  ResultFuture<bool> checkIfUserIsFirstTimer() async {
    try {
      final result = await _localDataSource.checkIfUserIsFirstTimer();
      return Right(result);
    } on CacheException catch (e) {
      return Left(
        CacheFailure(
          statusCode: e.statusCode,
          message: e.message,
        ),
      );
    }
  }
}

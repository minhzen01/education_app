import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions/server_exception.dart';
import 'package:education_app/core/errors/failures/server_failure.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/materials/data/datasources/material_remote_data_source.dart';
import 'package:education_app/src/course/features/materials/domain/entities/resource_entity.dart';
import 'package:education_app/src/course/features/materials/domain/repositories/material_repository.dart';

class MaterialRepositoryImpl extends MaterialRepository {
  const MaterialRepositoryImpl(this._remoteDataSource);

  final MaterialRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<void> addMaterial(ResourceEntity material) async {
    try {
      await _remoteDataSource.addMaterial(material);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<ResourceEntity>> getMaterials(String courseId) async {
    try {
      final result = await _remoteDataSource.getMaterials(courseId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}

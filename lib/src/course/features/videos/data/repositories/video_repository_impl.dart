import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions/server_exception.dart';
import 'package:education_app/core/errors/failures/server_failure.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/videos/data/datasources/video_remote_data_source.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video_entity.dart';
import 'package:education_app/src/course/features/videos/domain/repositories/video_repository.dart';

class VideoRepositoryImpl extends VideoRepository {
  const VideoRepositoryImpl(this._remoteDataSource);

  final VideoRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<void> addVideo(VideoEntity videoEntity) async {
    try {
      await _remoteDataSource.addVideo(videoEntity);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<VideoEntity>> getVideos(String courseId) async {
    try {
      final result = await _remoteDataSource.getVideos(courseId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}

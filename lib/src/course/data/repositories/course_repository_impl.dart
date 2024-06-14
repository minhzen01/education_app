import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions/server_exception.dart';
import 'package:education_app/core/errors/failures/server_failure.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/data/datasources/course_remote_data_source.dart';
import 'package:education_app/src/course/domain/entities/course.dart';
import 'package:education_app/src/course/domain/repositories/course_repository.dart';

class CourseRepositoryImpl extends CourseRepository {
  const CourseRepositoryImpl(
    this._remoteDataSource,
  );

  final CourseRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<void> addCourse(Course course) async {
    try {
      await _remoteDataSource.addCourse(course);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Course>> getCourses() async {
    try {
      final courses = await _remoteDataSource.getCourses();
      return Right(courses);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}

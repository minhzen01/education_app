import 'package:education_app/src/course/data/models/course_model.dart';
import 'package:education_app/src/course/domain/entities/course.dart';

abstract class CourseRemoteDataSource {
  const CourseRemoteDataSource();

  Future<List<CourseModel>> getCourses();

  Future<void> addCourse(Course course);
}

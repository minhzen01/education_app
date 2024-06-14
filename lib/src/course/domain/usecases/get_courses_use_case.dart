import 'package:education_app/core/usecases/use_case_without_params.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/domain/entities/course.dart';
import 'package:education_app/src/course/domain/repositories/course_repository.dart';

class GetCoursesUseCase extends UseCaseWithoutParams<List<Course>> {
  const GetCoursesUseCase(this._repository);

  final CourseRepository _repository;

  @override
  ResultFuture<List<Course>> call() async {
    return _repository.getCourses();
  }
}

import 'package:education_app/core/usecases/use_case_with_params.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/domain/entities/course.dart';
import 'package:education_app/src/course/domain/repositories/course_repository.dart';

class AddCourseUseCase extends UseCaseWithParams<void, Course> {
  const AddCourseUseCase(this._repository);

  final CourseRepository _repository;

  @override
  ResultFuture<void> call(Course params) async {
    return _repository.addCourse(params);
  }
}

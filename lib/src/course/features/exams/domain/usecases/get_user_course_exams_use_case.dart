import 'package:education_app/core/usecases/use_case_with_params.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/exams/domain/entities/user_exam_entity.dart';
import 'package:education_app/src/course/features/exams/domain/repositories/exam_repository.dart';

class GetUserCourseExamsUseCase extends UseCaseWithParams<List<UserExamEntity>, String> {
  const GetUserCourseExamsUseCase(this._repository);

  final ExamRepository _repository;

  @override
  ResultFuture<List<UserExamEntity>> call(String params) async {
    return _repository.getUserCourseExams(params);
  }
}

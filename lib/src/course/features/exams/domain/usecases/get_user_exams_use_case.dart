import 'package:education_app/core/usecases/use_case_without_params.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/exams/domain/entities/user_exam_entity.dart';
import 'package:education_app/src/course/features/exams/domain/repositories/exam_repository.dart';

class GetUserExamsUseCase extends UseCaseWithoutParams<List<UserExamEntity>> {
  const GetUserExamsUseCase(this._repository);

  final ExamRepository _repository;

  @override
  ResultFuture<List<UserExamEntity>> call() async {
    return _repository.getUserExams();
  }
}

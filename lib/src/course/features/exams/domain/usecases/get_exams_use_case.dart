import 'package:education_app/core/usecases/use_case_with_params.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam_entity.dart';
import 'package:education_app/src/course/features/exams/domain/repositories/exam_repository.dart';

class GetExamsUseCase extends UseCaseWithParams<List<ExamEntity>, String> {
  const GetExamsUseCase(this._repository);

  final ExamRepository _repository;

  @override
  ResultFuture<List<ExamEntity>> call(String params) async {
    return _repository.getExams(params);
  }
}

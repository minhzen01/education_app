import 'package:education_app/core/usecases/use_case_with_params.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam_entity.dart';
import 'package:education_app/src/course/features/exams/domain/repositories/exam_repository.dart';

class UploadExamUseCase extends UseCaseWithParams<void, ExamEntity> {
  const UploadExamUseCase(this._repository);

  final ExamRepository _repository;

  @override
  ResultFuture<void> call(ExamEntity params) async {
    return _repository.uploadExam(params);
  }
}

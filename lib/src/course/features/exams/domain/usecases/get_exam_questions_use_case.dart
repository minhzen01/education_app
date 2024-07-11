import 'package:education_app/core/usecases/use_case_with_params.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam_entity.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam_question_entity.dart';
import 'package:education_app/src/course/features/exams/domain/repositories/exam_repository.dart';

class GetExamQuestionsUseCase extends UseCaseWithParams<List<ExamQuestionEntity>, ExamEntity> {
  const GetExamQuestionsUseCase(this._repository);

  final ExamRepository _repository;

  @override
  ResultFuture<List<ExamQuestionEntity>> call(ExamEntity params) async {
    return _repository.getExamQuestions(params);
  }
}

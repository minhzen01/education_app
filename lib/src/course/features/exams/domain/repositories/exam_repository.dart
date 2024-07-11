import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam_entity.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam_question_entity.dart';
import 'package:education_app/src/course/features/exams/domain/entities/user_exam_entity.dart';

abstract class ExamRepository {
  const ExamRepository();

  ResultFuture<List<ExamEntity>> getExams(String courseId);

  ResultFuture<List<ExamQuestionEntity>> getExamQuestions(ExamEntity exam);

  ResultFuture<void> uploadExam(ExamEntity exam);

  ResultFuture<void> updateExam(ExamEntity exam);

  ResultFuture<void> submitExam(UserExamEntity exam);

  ResultFuture<List<UserExamEntity>> getUserExams();

  ResultFuture<List<UserExamEntity>> getUserCourseExams(String courseId);
}

import 'package:education_app/src/course/features/exams/data/models/exam_model.dart';
import 'package:education_app/src/course/features/exams/data/models/exam_question_model.dart';
import 'package:education_app/src/course/features/exams/data/models/user_exam_model.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam_entity.dart';
import 'package:education_app/src/course/features/exams/domain/entities/user_exam_entity.dart';

abstract class ExamRemoteDataSource {
  const ExamRemoteDataSource();

  Future<List<ExamModel>> getExams(String courseId);

  Future<void> uploadExam(ExamEntity exam);

  Future<List<ExamQuestionModel>> getExamQuestions(ExamEntity exam);

  Future<void> updateExam(ExamEntity exam);

  Future<void> submitExam(UserExamEntity exam);

  Future<List<UserExamModel>> getUserExams();

  Future<List<UserExamModel>> getUserCourseExams(String courseId);
}

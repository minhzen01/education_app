import 'package:education_app/src/course/features/exams/domain/entities/question_choice_entity.dart';
import 'package:equatable/equatable.dart';

class ExamQuestionEntity extends Equatable {
  const ExamQuestionEntity({
    required this.id,
    required this.courseId,
    required this.examId,
    required this.questionText,
    required this.choices,
    this.correctAnswer,
  });

  factory ExamQuestionEntity.empty() {
    return const ExamQuestionEntity(
      id: 'Test String',
      courseId: 'Test String',
      examId: 'Test String',
      questionText: 'Test String',
      choices: [],
    );
  }

  final String id;
  final String courseId;
  final String examId;
  final String questionText;
  final String? correctAnswer;
  final List<QuestionChoiceEntity> choices;

  @override
  List<Object?> get props => [id, examId, courseId];
}

import 'package:education_app/src/course/features/exams/domain/entities/exam_question_entity.dart';
import 'package:equatable/equatable.dart';

class ExamEntity extends Equatable {
  const ExamEntity({
    required this.id,
    required this.courseId,
    required this.title,
    required this.description,
    required this.timeLimit,
    this.imageUrl,
    this.questions,
  });

  factory ExamEntity.empty() {
    return const ExamEntity(
      id: 'Test String',
      courseId: 'Test String',
      title: 'Test String',
      description: 'Test String',
      timeLimit: 0,
      questions: [],
    );
  }

  final String id;
  final String courseId;
  final String title;
  final String? imageUrl;
  final String description;
  final int timeLimit;
  final List<ExamQuestionEntity>? questions;

  @override
  List<Object?> get props => [id, courseId];
}

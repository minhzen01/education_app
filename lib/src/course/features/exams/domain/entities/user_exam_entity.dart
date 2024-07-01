import 'package:education_app/src/course/features/exams/domain/entities/user_choice_entity.dart';
import 'package:equatable/equatable.dart';

class UserExamEntity extends Equatable {
  const UserExamEntity({
    required this.examId,
    required this.courseId,
    required this.totalQuestions,
    required this.examTitle,
    required this.dateSubmitted,
    required this.answers,
    this.examImageUrl,
  });

  factory UserExamEntity.empty([DateTime? date]) {
    return UserExamEntity(
      examId: 'Test String',
      courseId: 'Test String',
      totalQuestions: 0,
      examTitle: 'Test String',
      examImageUrl: 'Test String',
      dateSubmitted: date ?? DateTime.now(),
      answers: const [],
    );
  }

  final String examId;
  final String courseId;
  final int totalQuestions;
  final String examTitle;
  final String? examImageUrl;
  final DateTime dateSubmitted;
  final List<UserChoiceEntity> answers;

  @override
  List<Object?> get props => [examId, courseId];
}

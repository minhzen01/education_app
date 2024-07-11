import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/exams/data/models/question_choice_model.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam_question_entity.dart';
import 'package:education_app/src/course/features/exams/domain/entities/question_choice_entity.dart';

class ExamQuestionModel extends ExamQuestionEntity {
  const ExamQuestionModel({
    required super.id,
    required super.courseId,
    required super.examId,
    required super.questionText,
    required super.choices,
    super.correctAnswer,
  });

  factory ExamQuestionModel.empty() {
    return const ExamQuestionModel(
      id: 'Test String',
      courseId: 'Test String',
      examId: 'Test String',
      questionText: 'Test String',
      choices: [],
      correctAnswer: 'Test String',
    );
  }

  factory ExamQuestionModel.fromMap(DataMap map) {
    return ExamQuestionModel(
      id: map['id'] as String,
      courseId: map['courseId'] as String,
      examId: map['examId'] as String,
      questionText: map['questionText'] as String,
      correctAnswer: map['correctAnswer'] as String?,
      choices: List<DataMap>.from(map['choices'] as List<dynamic>).map(QuestionChoiceModel.fromMap).toList(),
    );
  }

  factory ExamQuestionModel.fromUploadMap(DataMap map) {
    return ExamQuestionModel(
      id: map['id'] as String? ?? '',
      courseId: map['courseId'] as String? ?? '',
      examId: map['examId'] as String? ?? '',
      questionText: map['question'] as String,
      correctAnswer: map['correct_answer'] as String?,
      choices: List<DataMap>.from(map['answers'] as List<dynamic>).map(QuestionChoiceModel.fromUploadMap).toList(),
    );
  }

  ExamQuestionModel copyWith({
    String? id,
    String? courseId,
    String? examId,
    String? questionText,
    String? correctAnswer,
    List<QuestionChoiceEntity>? choices,
  }) {
    return ExamQuestionModel(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      examId: examId ?? this.examId,
      questionText: questionText ?? this.questionText,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      choices: choices ?? this.choices,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'courseId': courseId,
      'examId': examId,
      'questionText': questionText,
      'choices': choices,
      'correctAnswer': correctAnswer,
    };
  }
}

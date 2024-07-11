import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/exams/domain/entities/question_choice_entity.dart';

class QuestionChoiceModel extends QuestionChoiceEntity {
  const QuestionChoiceModel({
    required super.questionId,
    required super.identifier,
    required super.choiceAnswer,
  });

  factory QuestionChoiceModel.empty() {
    return const QuestionChoiceModel(
      questionId: 'Test String',
      identifier: 'Test String',
      choiceAnswer: 'Test String',
    );
  }

  factory QuestionChoiceModel.fromMap(DataMap map) {
    return QuestionChoiceModel(
      questionId: map['questionId'] as String,
      identifier: map['identifier'] as String,
      choiceAnswer: map['choiceAnswer'] as String,
    );
  }

  factory QuestionChoiceModel.fromUploadMap(DataMap map) {
    return QuestionChoiceModel(
      questionId: 'Test String',
      identifier: map['identifier'] as String,
      choiceAnswer: map['Answer'] as String,
    );
  }

  QuestionChoiceModel copyWith({
    String? questionId,
    String? identifier,
    String? choiceAnswer,
  }) {
    return QuestionChoiceModel(
      questionId: questionId ?? this.questionId,
      identifier: identifier ?? this.identifier,
      choiceAnswer: choiceAnswer ?? this.choiceAnswer,
    );
  }

  DataMap toMap() {
    return {
      'questionId': questionId,
      'identifier': identifier,
      'choiceAnswer': choiceAnswer,
    };
  }
}

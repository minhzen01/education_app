import 'package:equatable/equatable.dart';

class QuestionChoiceEntity extends Equatable {
  const QuestionChoiceEntity({
    required this.questionId,
    required this.identifier,
    required this.choiceAnswer,
  });

  final String questionId;
  final String identifier;
  final String choiceAnswer;

  @override
  List<Object?> get props => [questionId, identifier, choiceAnswer];
}

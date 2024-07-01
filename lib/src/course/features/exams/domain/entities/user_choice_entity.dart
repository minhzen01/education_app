import 'package:equatable/equatable.dart';

class UserChoiceEntity extends Equatable {
  const UserChoiceEntity({
    required this.userChoice,
    required this.questionId,
    required this.correctChoice,
  });

  final String userChoice;
  final String questionId;
  final String correctChoice;

  bool get isCorrect => userChoice == correctChoice;

  @override
  List<Object?> get props => [questionId, userChoice];
}

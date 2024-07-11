import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/exams/domain/entities/user_choice_entity.dart';

class UserChoiceModel extends UserChoiceEntity {
  const UserChoiceModel({
    required super.userChoice,
    required super.questionId,
    required super.correctChoice,
  });

  factory UserChoiceModel.empty() {
    return const UserChoiceModel(
      userChoice: 'Test String',
      questionId: 'Test String',
      correctChoice: 'Test String',
    );
  }

  factory UserChoiceModel.fromMap(DataMap map) {
    return UserChoiceModel(
      userChoice: map['userChoice'] as String,
      questionId: map['questionId'] as String,
      correctChoice: map['correctChoice'] as String,
    );
  }

  factory UserChoiceModel.fromUploadMap(DataMap map) {
    return UserChoiceModel(
      questionId: map['questionId'] as String,
      userChoice: map['userChoice'] as String,
      correctChoice: map['Answer'] as String,
    );
  }

  UserChoiceModel copyWith({
    String? questionId,
    String? userChoice,
    String? correctChoice,
  }) {
    return UserChoiceModel(
      questionId: questionId ?? this.questionId,
      userChoice: userChoice ?? this.userChoice,
      correctChoice: correctChoice ?? this.correctChoice,
    );
  }

  DataMap toMap() {
    return {
      'questionId': questionId,
      'userChoice': userChoice,
      'correctChoice': correctChoice,
    };
  }
}

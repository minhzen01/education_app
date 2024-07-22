import 'package:education_app/core/res/app_colors.dart';
import 'package:education_app/src/course/features/exams/domain/entities/user_choice_entity.dart';
import 'package:flutter/material.dart';

class ExamHistoryAnswerTile extends StatelessWidget {
  const ExamHistoryAnswerTile({
    required this.answer,
    required this.index,
    super.key,
  });

  final UserChoiceEntity answer;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      expandedAlignment: Alignment.centerLeft,
      title: Text(
        'Question $index',
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        answer.isCorrect ? 'Right' : 'Wrong',
        style: TextStyle(
          color: answer.isCorrect ? AppColors.greenColour : AppColors.redColour,
          fontWeight: FontWeight.w600,
        ),
      ),
      children: [
        Text(
          'Your Answer: ${answer.userChoice}',
          style: TextStyle(
            color: answer.isCorrect ? AppColors.greenColour : AppColors.redColour,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

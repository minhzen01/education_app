import 'package:education_app/core/common/widgets/time_text.dart';
import 'package:education_app/core/res/app_colors.dart';
import 'package:flutter/material.dart';

class TimeTile extends StatelessWidget {
  const TimeTile({
    required this.time,
    super.key,
    this.prefixText,
  });

  final DateTime time;
  final String? prefixText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryColour,
        borderRadius: BorderRadius.circular(90),
      ),
      child: TimeText(
        time: time,
        prefixText: prefixText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

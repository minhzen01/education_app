import 'package:education_app/core/common/widgets/app_text_field.dart';
import 'package:education_app/core/res/app_colors.dart';
import 'package:flutter/material.dart';

class TitleInputField extends StatelessWidget {
  const TitleInputField({
    required this.controller,
    required this.title,
    this.required = true,
    super.key,
    this.hintText,
    this.hintStyle,
    this.suffixIcon,
  });

  final bool required;
  final TextEditingController controller;
  final String title;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                text: title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.neutralTextColour,
                ),
                children: !required
                    ? null
                    : [
                        const TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: AppColors.redColour,
                          ),
                        ),
                      ],
              ),
            ),
            if (suffixIcon != null) suffixIcon!,
          ],
        ),
        const SizedBox(height: 10),
        AppTextField(
          controller: controller,
          hintText: hintText ?? 'Enter $title',
          hintStyle: hintStyle,
          overrideValidator: true,
          validator: (value) {
            if (!required) return null;
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ),
      ],
    );
  }
}

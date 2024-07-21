import 'dart:io';

import 'package:education_app/core/res/app_colors.dart';
import 'package:education_app/src/notifications/data/models/notification_model.dart';
import 'package:education_app/src/notifications/domain/entities/notification_entity.dart';
import 'package:education_app/src/notifications/presentation/cubit/notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CoreUtils {
  const CoreUtils._();

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.primaryColour,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(10),
        ),
      );
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  static Future<File?> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) return File(image.path);
    return null;
  }

  static void sendNotification({
    required BuildContext context,
    required String title,
    required String body,
    required NotificationCategory category,
  }) {
    context.read<NotificationCubit>().sendNotification(
      NotificationModel.empty().copyWith(
        title: title,
        body: body,
        category: category,
      ),
    );
  }
}

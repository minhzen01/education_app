import 'dart:io';
import 'package:education_app/core/common/widgets/title_input_field.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/src/authentication/data/datasources/auth_constants.dart';
import 'package:education_app/src/course/data/models/course_model.dart';
import 'package:education_app/src/course/features/videos/presentation/utils/video_utils.dart';
import 'package:education_app/src/course/presentation/cubit/course_cubit.dart';
import 'package:education_app/src/notifications/domain/entities/notification_entity.dart';
import 'package:education_app/src/notifications/presentation/widgets/notification_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCourseSheet extends StatefulWidget {
  const AddCourseSheet({super.key});

  @override
  State<AddCourseSheet> createState() => _AddCourseSheetState();
}

class _AddCourseSheetState extends State<AddCourseSheet> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  File? image;

  bool isFile = false;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    imageController.addListener(() {
      if (isFile && imageController.text.trim().isEmpty) {
        image = null;
        isFile = false;
      }
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationWrapper(
      onNotificationSent: () {
        if (loading) {
          Navigator.of(context).pop();
        }
        Navigator.of(context).pop();
      },
      child: BlocListener<CourseCubit, CourseState>(
        listener: (_, state) async {
          if (state is CourseErrorState) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is AddingCourseState) {
            loading = true;
            CoreUtils.showLoadingDialog(context);
          } else if (state is CourseAddedState) {
            if (loading) {
              loading = false;
              Navigator.of(context).pop();
            }
            CoreUtils.showSnackBar(context, 'Course added successfully');
            loading = true;
            VideoUtils.sendNotification(
              context: context,
              title: 'New Course(${titleController.text.trim()})',
              body: 'A new course has been added',
              category: NotificationCategory.COURSE,
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            child: Form(
              key: formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  const Text(
                    'Add Course',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TitleInputField(
                    controller: titleController,
                    title: 'Course Title',
                  ),
                  const SizedBox(height: 20),
                  TitleInputField(
                    controller: descriptionController,
                    title: 'Description',
                    required: false,
                  ),
                  const SizedBox(height: 20),
                  TitleInputField(
                    controller: imageController,
                    title: 'Course Image',
                    required: false,
                    hintText: 'Enter image URL or pick from gallery',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        final image = await CoreUtils.pickImage();
                        if (image != null) {
                          isFile = true;
                          this.image = image;
                          final imageName = image.path.split('/').last;
                          imageController.text = imageName;
                        }
                      },
                      icon: const Icon(Icons.add_photo_alternate_outlined),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              final now = DateTime.now();
                              final course = CourseModel.empty().copyWith(
                                title: titleController.text.trim(),
                                description: descriptionController.text.trim(),
                                image: imageController.text.trim().isEmpty
                                    ? AuthConst.kDefaultAvatar
                                    : isFile
                                        ? image!.path
                                        : imageController.text.trim(),
                                createdAt: now,
                                updatedAt: now,
                                imageIsFile: isFile,
                              );
                              context.read<CourseCubit>().addCourse(course);
                            }
                          },
                          child: const Text('Add'),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

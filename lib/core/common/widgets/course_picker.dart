import 'package:education_app/core/res/app_colors.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/src/course/domain/entities/course.dart';
import 'package:education_app/src/course/presentation/cubit/course_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoursePicker extends StatefulWidget {
  const CoursePicker({
    required this.controller,
    required this.notifier,
    super.key,
  });

  final TextEditingController controller;
  final ValueNotifier<Course?> notifier;

  @override
  State<CoursePicker> createState() => _CoursePickerState();
}

class _CoursePickerState extends State<CoursePicker> {
  void getCourses() {
    context.read<CourseCubit>().getCourses();
  }

  @override
  void initState() {
    super.initState();
    getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseCubit, CourseState>(
      listener: (context, state) {
        if (state is CourseErrorState) {
          CoreUtils.showSnackBar(context, state.message);
          Navigator.of(context).pop();
        } else if (state is CourseLoadedState && state.courses.isEmpty) {
          CoreUtils.showSnackBar(context, 'No courses found\nPlease add a course first');
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return TextFormField(
          controller: widget.controller,
          readOnly: true,
          decoration: InputDecoration(
            labelText: 'Pick Course',
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColour),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            suffixIcon: state is CourseLoadedState
                ? PopupMenuButton<String>(
                    offset: const Offset(0, 50),
                    surfaceTintColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    icon: const Icon(Icons.arrow_drop_down),
                    itemBuilder: (context) {
                      return state.courses
                          .map(
                            (e) => PopupMenuItem<String>(
                              value: e.id,
                              child: Text(e.title),
                              onTap: () {
                                widget.controller.text = e.title;
                                widget.notifier.value = e;
                              },
                            ),
                          )
                          .toList();
                    },
                  )
                : const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Loading...',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please pick a course';
            }
            return null;
          },
        );
      },
    );
  }
}

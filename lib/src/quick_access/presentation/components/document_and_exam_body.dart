import 'package:education_app/core/common/widgets/course_tile.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/services/injection_container.dart';
import 'package:education_app/src/course/domain/entities/course.dart';
import 'package:education_app/src/course/features/exams/presentation/cubit/exam_cubit.dart';
import 'package:education_app/src/course/features/exams/presentation/views/course_exams_screen.dart';
import 'package:education_app/src/course/features/materials/presentation/cubit/material_cubit.dart';
import 'package:education_app/src/course/features/materials/presentation/views/course_materials_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DocumentAndExamBody extends StatelessWidget {
  const DocumentAndExamBody({
    required this.courses,
    required this.index,
    super.key,
  });

  final List<Course> courses;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20).copyWith(top: 5),
      children: [
        Center(
          child: Wrap(
            spacing: 20,
            runSpacing: 40,
            runAlignment: WrapAlignment.spaceEvenly,
            children: courses.map(
              (e) {
                return CourseTile(
                  course: e,
                  onTap: () {
                    context.push(
                      index == 0
                          ? BlocProvider(
                              create: (_) => sl<MaterialCubit>(),
                              child: CourseMaterialsScreen(course: e),
                            )
                          : BlocProvider(
                              create: (_) => sl<ExamCubit>(),
                              child: CourseExamsScreen(course: e),
                            ),
                    );
                  },
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}

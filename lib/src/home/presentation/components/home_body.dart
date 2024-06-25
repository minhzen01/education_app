import 'package:education_app/core/common/app/providers/course_of_the_day_notifier.dart';
import 'package:education_app/core/common/views/loading_view.dart';
import 'package:education_app/core/common/widgets/not_found_text.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/src/course/presentation/cubit/course_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    super.initState();
    getCourses();
  }

  void getCourses() {
    context.read<CourseCubit>().getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      listener: (_, state) {
        if (state is CourseErrorState) {
          CoreUtils.showSnackBar(context, state.message);
        } else if (state is CourseLoadedState && state.courses.isNotEmpty) {
          final courses = state.courses..shuffle();
          final courseOfTheDay = courses.first;
          context.read<CourseOfTheDayNotifier>().setCourseOfTheDay(courseOfTheDay);
        }
      },
      builder: (context, state) {
        if (state is LoadingCoursesState) {
          return const LoadingView();
        } else if (state is CourseLoadedState && state.courses.isEmpty || state is CourseErrorState) {
          return const NotFoundText(text: 'No courses found\nPlease contact admin or if you are admin, add courses');
        } else if (state is CourseLoadedState && state.courses.isNotEmpty) {
          final courses = state.courses..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [

            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

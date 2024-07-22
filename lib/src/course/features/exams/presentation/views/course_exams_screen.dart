import 'package:education_app/core/common/views/loading_view.dart';
import 'package:education_app/core/common/widgets/nested_back_button.dart';
import 'package:education_app/core/common/widgets/not_found_text.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/extensions/int_extensions.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/src/course/domain/entities/course.dart';
import 'package:education_app/src/course/features/exams/presentation/cubit/exam_cubit.dart';
import 'package:education_app/src/course/features/exams/presentation/views/exam_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseExamsScreen extends StatefulWidget {
  const CourseExamsScreen({
    required this.course,
    super.key,
  });

  static const routeName = '/course-exams';

  final Course course;

  @override
  State<CourseExamsScreen> createState() => _CourseExamsScreenState();
}

class _CourseExamsScreenState extends State<CourseExamsScreen> {
  void getExams() {
    context.read<ExamCubit>().getExams(widget.course.id);
  }

  @override
  void initState() {
    super.initState();
    getExams();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('${widget.course.title} Exams'),
        leading: const NestedBackButton(),
      ),
      body: BlocConsumer<ExamCubit, ExamState>(
        listener: (context, state) {
          if (state is ExamErrorState) {
            CoreUtils.showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is GettingExamsState) {
            return const LoadingView();
          } else if ((state is ExamsLoadedState && state.list.isEmpty) || state is ExamErrorState) {
            return NotFoundText(text: 'No videos found for ${widget.course.title}');
          } else if (state is ExamsLoadedState) {
            return SafeArea(
              child: ListView.builder(
                padding: const EdgeInsets.all(20),
                itemBuilder: (_, index) {
                  final exam = state.list[index];
                  return Stack(
                    children: [
                      Card(
                        margin: const EdgeInsets.all(4).copyWith(bottom: 30),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                exam.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(exam.description),
                              const SizedBox(height: 10),
                              Text(
                                exam.timeLimit.displayDuration,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: context.width * .2, vertical: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                ExamDetailsScreen.routeName,
                                arguments: exam,
                              );
                            },
                            child: const Text('Take Exam'),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                itemCount: state.list.length,
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

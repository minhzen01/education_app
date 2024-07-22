import 'package:education_app/core/common/widgets/course_info_tile.dart';
import 'package:education_app/core/common/widgets/gradient_background.dart';
import 'package:education_app/core/common/widgets/rounded_button.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/extensions/int_extensions.dart';
import 'package:education_app/core/res/app_colors.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/src/course/features/exams/data/models/exam_model.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam_entity.dart';
import 'package:education_app/src/course/features/exams/presentation/cubit/exam_cubit.dart';
import 'package:education_app/src/course/features/exams/presentation/views/exam_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamDetailsScreen extends StatefulWidget {
  const ExamDetailsScreen({
    required this.exam,
    super.key,
  });

  static const routeName = '/exam-details';

  final ExamEntity exam;

  @override
  State<ExamDetailsScreen> createState() => _ExamDetailsScreenState();
}

class _ExamDetailsScreenState extends State<ExamDetailsScreen> {
  late ExamEntity completeExam;

  void getQuestions() {
    context.read<ExamCubit>().getExamQuestions(widget.exam);
  }

  @override
  void initState() {
    completeExam = widget.exam;
    super.initState();
    getQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: Text(widget.exam.title)),
      body: GradientBackground(
        image: MediaRes.documentsGradientBackground,
        child: BlocConsumer<ExamCubit, ExamState>(
          listener: (context, state) {
            if (state is ExamErrorState) {
              CoreUtils.showSnackBar(context, state.message);
            } else if (state is ExamQuestionsLoadedState) {
              completeExam = (completeExam as ExamModel).copyWith(
                questions: state.list,
              );
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          Center(
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.physicsTileColour,
                              ),
                              child: Center(
                                child: completeExam.imageUrl != null
                                    ? Image.network(
                                        completeExam.imageUrl!,
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        MediaRes.test,
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            completeExam.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            completeExam.description,
                            style: const TextStyle(
                              color: AppColors.neutralTextColour,
                            ),
                          ),
                          const SizedBox(height: 20),
                          CourseInfoTile(
                            image: MediaRes.examTime,
                            title: '${completeExam.timeLimit.displayDurationLong} for the test.',
                            subtitle: 'Complete the test in ${completeExam.timeLimit.displayDurationLong}',
                          ),
                          if (state is ExamQuestionsLoadedState) ...[
                            const SizedBox(height: 10),
                            CourseInfoTile(
                              image: MediaRes.examQuestions,
                              title: '${completeExam.questions?.length} Questions',
                              subtitle: 'This test consists of ${completeExam.questions?.length} questions',
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (state is GettingExamQuestionsState)
                      const Center(child: LinearProgressIndicator())
                    else if (state is ExamQuestionsLoadedState)
                      RoundedButton(
                        label: 'Start Exam',
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            ExamScreen.routeName,
                            arguments: completeExam,
                          );
                        },
                      )
                    else
                      Text(
                        'No Questions for this exam',
                        style: context.theme.textTheme.titleLarge,
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:education_app/core/res/app_colors.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/src/course/features/exams/presentation/cubit/exam_cubit.dart';
import 'package:education_app/src/course/features/exams/presentation/widgets/exam_navigation_blob.dart';
import 'package:education_app/src/course/features/exams/presentation/providers/exam_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  static const routeName = '/exam';

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  bool showingLoader = false;

  late ExamController examController;

  Future<void> submitExam() async {
    if (!examController.isTimeUp) {
      examController.stopTimer();
      final isMinutesLeft = examController.remainingTimeInSeconds > 60;
      final isHoursLeft = examController.remainingTimeInSeconds > 3600;
      final timeLeftText = isHoursLeft
          ? 'hours'
          : isMinutesLeft
              ? 'minutes'
              : 'seconds';
      final endExam = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
            title: const Text('Submit Exam?'),
            content: Text('You have ${examController.remainingTime} $timeLeftText left.\nAre you sure you want to submit?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: AppColors.redColour,
                  ),
                ),
              ),
            ],
          );
        },
      );
      if (endExam ?? false) {
        return collectAndSend();
      } else {
        examController.startTimer();
        return;
      }
    }
    collectAndSend();
  }

  void collectAndSend() {
    final exam = examController.userExam;
    context.read<ExamCubit>().submitExam(exam);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      examController.addListener(() {
        if (examController.isTimeUp) submitExam();
      });
    });
  }

  @override
  void dispose() {
    examController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExamController>(
      builder: (_, controller, __) {
        return BlocConsumer<ExamCubit, ExamState>(
          listener: (_, state) {
            if (showingLoader) {
              Navigator.of(context).pop();
            }
            if (state is ExamErrorState) {
              CoreUtils.showSnackBar(context, state.message);
            } else if (state is SubmittingExamState) {
              CoreUtils.showLoadingDialog(context);
            } else if (state is ExamSubmittedState) {
              CoreUtils.showSnackBar(context, 'Exam Submitted');
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            return WillPopScope(
              onWillPop: () async {
                if (state is SubmittingExamState) return false;
                if (controller.isTimeUp) return true;
                final result = await showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog.adaptive(
                      title: const Text('Edit Exam'),
                      content: const Text('Are you sure you want to Exit the exam'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: const Text('Exit exam'),
                        ),
                      ],
                    );
                  },
                );
                return result ?? false;
              },
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  centerTitle: true,
                  title: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(MediaRes.examTimeRed, height: 30, width: 30),
                      const SizedBox(width: 10),
                      Text(
                        controller.remainingTime,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.redColour,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: submitExam,
                      child: const Text(
                        'Submit',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView(
                            children: [
                              Text(
                                'Questions ${controller.currentIndex + 1}',
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Color(0xFF666E7A),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFC4C4C4),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Center(
                                  child: controller.exam.imageUrl == null
                                      ? Image.asset(
                                          MediaRes.test,
                                          height: 20,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          controller.exam.imageUrl!,
                                          height: 200,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                controller.currentQuestion.questionText,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final choice = controller.currentQuestion.choices[index];
                                  return RadioListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(
                                      '${choice.identifier}. ${choice.choiceAnswer}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    value: choice.identifier,
                                    groupValue: controller.userAnswer?.userChoice,
                                    onChanged: (value) {
                                      controller.answer(choice);
                                    },
                                  );
                                },
                                itemCount: controller.currentQuestion.choices.length,
                              ),

                            ],
                          ),
                        ),
                        const ExamNavigationBlob(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

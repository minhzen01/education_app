import 'dart:async';
import 'package:education_app/src/course/features/exams/data/models/user_choice_model.dart';
import 'package:education_app/src/course/features/exams/data/models/user_exam_model.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam_entity.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam_question_entity.dart';
import 'package:education_app/src/course/features/exams/domain/entities/question_choice_entity.dart';
import 'package:education_app/src/course/features/exams/domain/entities/user_choice_entity.dart';
import 'package:education_app/src/course/features/exams/domain/entities/user_exam_entity.dart';
import 'package:flutter/foundation.dart';

class ExamController extends ChangeNotifier {
  ExamController({required ExamEntity exam})
      : _exam = exam,
        _questions = exam.questions! {
    _userExam = UserExamModel(
      examId: exam.id,
      courseId: exam.courseId,
      totalQuestions: exam.questions!.length,
      examImageUrl: exam.imageUrl,
      examTitle: exam.title,
      dateSubmitted: DateTime.now(),
      answers: const [],
    );
    _remainingTime = exam.timeLimit;
  }

  final ExamEntity _exam;

  ExamEntity get exam => _exam;
  final List<ExamQuestionEntity> _questions;

  List<ExamQuestionEntity> get questions => _questions;

  int get totalQuestions => _questions.length;
  late UserExamEntity _userExam;

  UserExamEntity get userExam => _userExam;

  late int _remainingTime;

  bool get isTimeUp => _remainingTime == 0;
  bool _examStarted = false;

  bool get examStarted => _examStarted;

  Timer? _timer;

  String get remainingTime {
    final minutes = (_remainingTime ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingTime % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  int get remainingTimeInSeconds => _remainingTime;

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  ExamQuestionEntity get currentQuestion => _questions[_currentIndex];

  void startTimer() {
    _examStarted = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  UserChoiceEntity? get userAnswer {
    final answers = _userExam.answers;
    var noAnswer = false;
    final questionId = currentQuestion.id;
    final userChoice = answers.firstWhere(
      (answer) => answer.questionId == questionId,
      orElse: () {
        noAnswer = true;
        return UserChoiceModel.empty();
      },
    );
    return noAnswer ? null : userChoice;
  }

  void changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void nextQuestions() {
    if (!_examStarted) startTimer();
    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  void answer(QuestionChoiceEntity choice) {
    if (!_examStarted && currentIndex == 0) startTimer();
    final answers = List<UserChoiceEntity>.of(_userExam.answers);
    final userChoice = UserChoiceModel(
      userChoice: choice.identifier,
      questionId: choice.questionId,
      correctChoice: currentQuestion.correctAnswer!,
    );
    if (answers.any((answer) => answer.questionId == userChoice.questionId)) {
      final index = answers.indexWhere((answer) => answer.questionId == userChoice.questionId);
      answers[index] = userChoice;
    } else {
      answers.add(userChoice);
    }
    _userExam = (_userExam as UserExamModel).copyWith(answers: answers);
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

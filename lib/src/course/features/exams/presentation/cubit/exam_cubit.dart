import 'package:education_app/src/course/features/exams/domain/entities/exam_entity.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam_question_entity.dart';
import 'package:education_app/src/course/features/exams/domain/entities/user_exam_entity.dart';
import 'package:education_app/src/course/features/exams/domain/usecases/get_exam_questions_use_case.dart';
import 'package:education_app/src/course/features/exams/domain/usecases/get_exams_use_case.dart';
import 'package:education_app/src/course/features/exams/domain/usecases/get_user_course_exams_use_case.dart';
import 'package:education_app/src/course/features/exams/domain/usecases/get_user_exams_use_case.dart';
import 'package:education_app/src/course/features/exams/domain/usecases/submit_exam_use_case.dart';
import 'package:education_app/src/course/features/exams/domain/usecases/update_exam_use_case.dart';
import 'package:education_app/src/course/features/exams/domain/usecases/upload_exam_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'exam_state.dart';

class ExamCubit extends Cubit<ExamState> {
  ExamCubit(
    this._getExamQuestionsUseCase,
    this._getExamsUseCase,
    this._submitExamUseCase,
    this._updateExamUseCase,
    this._uploadExamUseCase,
    this._getUserCourseExamsUseCase,
    this._getUserExamsUseCase,
  ) : super(const ExamInitialState());

  final GetExamQuestionsUseCase _getExamQuestionsUseCase;
  final GetExamsUseCase _getExamsUseCase;
  final SubmitExamUseCase _submitExamUseCase;
  final UpdateExamUseCase _updateExamUseCase;
  final UploadExamUseCase _uploadExamUseCase;
  final GetUserCourseExamsUseCase _getUserCourseExamsUseCase;
  final GetUserExamsUseCase _getUserExamsUseCase;

  Future<void> getExamQuestions(ExamEntity exam) async {
    emit(const GettingExamQuestionsState());
    final result = await _getExamQuestionsUseCase.call(exam);
    result.fold(
      (failure) => emit(ExamErrorState(message: failure.errorMessage)),
      (success) => emit(ExamQuestionsLoadedState(list: success)),
    );
  }

  Future<void> getExams(String courseId) async {
    emit(const GettingExamsState());
    final result = await _getExamsUseCase.call(courseId);
    result.fold(
      (failure) => emit(ExamErrorState(message: failure.errorMessage)),
      (success) => emit(ExamsLoadedState(list: success)),
    );
  }

  Future<void> submitExam(UserExamEntity exam) async {
    emit(const SubmittingExamState());
    final result = await _submitExamUseCase.call(exam);
    result.fold(
      (failure) => emit(ExamErrorState(message: failure.errorMessage)),
      (success) => emit(const ExamSubmittedState()),
    );
  }

  Future<void> updateExam(ExamEntity exam) async {
    emit(const UpdatingExamState());
    final result = await _updateExamUseCase.call(exam);
    result.fold(
      (failure) => emit(ExamErrorState(message: failure.errorMessage)),
      (success) => emit(const ExamUpdatedState()),
    );
  }

  Future<void> uploadExam(ExamEntity exam) async {
    emit(const UploadingExamState());
    final result = await _uploadExamUseCase.call(exam);
    result.fold(
      (failure) => emit(ExamErrorState(message: failure.errorMessage)),
      (success) => emit(const ExamUploadedState()),
    );
  }

  Future<void> getUserCourseExams(String courseId) async {
    emit(const GettingUserExamsState());
    final result = await _getUserCourseExamsUseCase.call(courseId);
    result.fold(
      (failure) => emit(ExamErrorState(message: failure.errorMessage)),
      (success) => emit(UserCourseExamsLoadedState(list: success)),
    );
  }

  Future<void> getUserExams() async {
    emit(const GettingUserExamsState());
    final result = await _getUserExamsUseCase.call();
    result.fold(
      (failure) => emit(ExamErrorState(message: failure.errorMessage)),
      (success) => emit(UserExamsLoadedState(list: success)),
    );
  }
}

part of 'exam_cubit.dart';

sealed class ExamState extends Equatable {
  const ExamState();

  @override
  List<Object?> get props => [];
}

class ExamInitialState extends ExamState {
  const ExamInitialState();
}

class GettingExamQuestionsState extends ExamState {
  const GettingExamQuestionsState();
}

class ExamQuestionsLoadedState extends ExamState {
  const ExamQuestionsLoadedState({required this.list});

  final List<ExamQuestionEntity> list;

  @override
  List<Object?> get props => [list];
}

class ExamErrorState extends ExamState {
  const ExamErrorState({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

class GettingExamsState extends ExamState {
  const GettingExamsState();
}

class ExamsLoadedState extends ExamState {
  const ExamsLoadedState({required this.list});

  final List<ExamEntity> list;

  @override
  List<Object?> get props => [list];
}

class SubmittingExamState extends ExamState {
  const SubmittingExamState();
}

class ExamSubmittedState extends ExamState {
  const ExamSubmittedState();
}

class UpdatingExamState extends ExamState {
  const UpdatingExamState();
}

class ExamUpdatedState extends ExamState {
  const ExamUpdatedState();
}

class UploadingExamState extends ExamState {
  const UploadingExamState();
}

class ExamUploadedState extends ExamState {
  const ExamUploadedState();
}

class GettingUserExamsState extends ExamState {
  const GettingUserExamsState();
}

class UserCourseExamsLoadedState extends ExamState {
  const UserCourseExamsLoadedState({required this.list});

  final List<UserExamEntity> list;

  @override
  List<Object?> get props => [list];
}

class UserExamsLoadedState extends ExamState {
  const UserExamsLoadedState({required this.list});

  final List<UserExamEntity> list;

  @override
  List<Object?> get props => [list];
}

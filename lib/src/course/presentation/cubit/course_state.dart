part of 'course_cubit.dart';

abstract class CourseState extends Equatable {
  const CourseState();

  @override
  List<Object?> get props => [];
}

class CourseInitialState extends CourseState {
  const CourseInitialState();
}

class LoadingCoursesState extends CourseState {
  const LoadingCoursesState();
}

class AddingCourseState extends CourseState {
  const AddingCourseState();
}

class CourseAddedState extends CourseState {
  const CourseAddedState();
}

class CourseLoadedState extends CourseState {
  const CourseLoadedState({required this.courses});

  final List<Course> courses;

  @override
  List<Object?> get props => [courses];
}

class CourseErrorState extends CourseState {
  const CourseErrorState({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

import 'package:bloc/bloc.dart';
import 'package:education_app/src/course/domain/entities/course.dart';
import 'package:education_app/src/course/domain/usecases/add_course_use_case.dart';
import 'package:education_app/src/course/domain/usecases/get_courses_use_case.dart';
import 'package:equatable/equatable.dart';

part 'course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit(
    this._addCourseUseCase,
    this._getCoursesUseCase,
  ) : super(const CourseInitialState());

  final AddCourseUseCase _addCourseUseCase;
  final GetCoursesUseCase _getCoursesUseCase;

  Future<void> addCourse(Course course) async {
    emit(const AddingCourseState());
    final result = await _addCourseUseCase.call(course);
    result.fold(
      (failure) => emit(CourseErrorState(message: failure.errorMessage)),
      (success) => emit(const CourseAddedState()),
    );
  }

  Future<void> getCourses() async {
    emit(const LoadingCoursesState());
    final result = await _getCoursesUseCase.call();
    result.fold(
      (failure) => emit(CourseErrorState(message: failure.errorMessage)),
      (success) => emit(CourseLoadedState(courses: success)),
    );
  }
}

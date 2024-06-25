import 'package:education_app/src/course/domain/entities/course.dart';
import 'package:flutter/cupertino.dart';

class CourseOfTheDayNotifier extends ChangeNotifier {
  Course? _courseOfTheDay;

  Course? get courseOfTheDay => _courseOfTheDay;

  void setCourseOfTheDay(Course course) {
    if (_courseOfTheDay != course) {
      _courseOfTheDay ??= course;
      notifyListeners();
    }
  }
}

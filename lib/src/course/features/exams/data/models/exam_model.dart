import 'dart:convert';

import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/exams/data/models/exam_question_model.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam_entity.dart';
import 'package:education_app/src/course/features/exams/domain/entities/exam_question_entity.dart';

class ExamModel extends ExamEntity {
  const ExamModel({
    required super.id,
    required super.courseId,
    required super.title,
    required super.description,
    required super.timeLimit,
    super.imageUrl,
    super.questions,
  });

  factory ExamModel.empty() {
    return const ExamModel(
      id: 'Test String',
      courseId: 'Test String',
      title: 'Test String',
      description: 'Test String',
      timeLimit: 0,
      questions: [],
    );
  }

  factory ExamModel.fromMap(DataMap map) {
    return ExamModel(
      id: map['id'] as String,
      courseId: map['courseId'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      timeLimit: (map['timeLimit'] as num).toInt(),
      imageUrl: map['imageUrl'] as String?,
    );
  }

  factory ExamModel.fromJson(String source) {
    return ExamModel.fromUploadMap(jsonDecode(source) as DataMap);
  }

  factory ExamModel.fromUploadMap(DataMap map) {
    return ExamModel(
      id: map['id'] as String? ?? '',
      courseId: map['courseId'] as String? ?? '',
      title: map['title'] as String,
      description: map['description'] as String,
      timeLimit: (map['timeLimit'] as num).toInt(),
      imageUrl: map['imageUrl'] as String?,
      questions: List<DataMap>.from(map['question'] as List<dynamic>).map(ExamQuestionModel.fromUploadMap).toList(),
    );
  }

  ExamModel copyWith({
    String? id,
    String? courseId,
    String? title,
    String? imageUrl,
    String? description,
    int? timeLimit,
    List<ExamQuestionEntity>? questions,
  }) {
    return ExamModel(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      timeLimit: timeLimit ?? this.timeLimit,
      questions: questions ?? this.questions,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'courseId': courseId,
      'title': title,
      'description': description,
      'timeLimit': timeLimit,
      'imageUrl': imageUrl,
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/materials/domain/entities/resource_entity.dart';

class ResourceModel extends ResourceEntity {
  const ResourceModel({
    required super.id,
    required super.courseId,
    required super.uploadTime,
    required super.fileURL,
    required super.isFile,
    required super.fileExtension,
    super.title,
    super.author,
    super.description,
  });

  factory ResourceModel.empty([DateTime? date]) {
    return ResourceModel(
      id: '_empty.id',
      courseId: '_empty.courseId',
      uploadTime: date ?? DateTime.now(),
      fileURL: '_empty.fileURL',
      isFile: true,
      fileExtension: '_empty.fileExtension',
      title: '_empty.title',
      description: '_empty.description',
      author: '_empty.author',
    );
  }

  factory ResourceModel.fromMap(DataMap map) {
    return ResourceModel(
      id: map['id'] as String,
      title: map['title'] as String?,
      description: map['description'] as String?,
      uploadTime: (map['uploadTime'] as Timestamp).toDate(),
      fileExtension: map['fileExtension'] as String,
      isFile: map['isFile'] as bool,
      courseId: map['courseId'] as String,
      fileURL: map['fileURL'] as String,
      author: map['author'] as String?,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'uploadTime': FieldValue.serverTimestamp(),
      'courseId': courseId,
      'fileURL': fileURL,
      'author': author,
      'isFile': isFile,
      'fileExtension': fileExtension,
    };
  }

  ResourceModel copyWith({
    String? id,
    String? courseId,
    DateTime? uploadTime,
    String? fileURL,
    String? fileExtension,
    bool? isFile,
    String? title,
    String? author,
    String? description,
  }) {
    return ResourceModel(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      uploadTime: uploadTime ?? this.uploadTime,
      fileURL: fileURL ?? this.fileURL,
      fileExtension: fileExtension ?? this.fileExtension,
      isFile: isFile ?? this.isFile,
      title: title ?? this.title,
      author: author ?? this.author,
      description: description ?? this.description,
    );
  }
}

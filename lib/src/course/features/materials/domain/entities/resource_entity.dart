import 'package:equatable/equatable.dart';

class ResourceEntity extends Equatable {
  const ResourceEntity({
    required this.id,
    required this.courseId,
    required this.uploadTime,
    required this.fileURL,
    required this.isFile,
    required this.fileExtension,
    this.title,
    this.author,
    this.description,
  });

  factory ResourceEntity.empty([DateTime? date]) {
    return ResourceEntity(
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

  final String id;
  final String courseId;
  final DateTime uploadTime;
  final String fileURL;
  final String fileExtension;
  final bool isFile;
  final String? title;
  final String? author;
  final String? description;

  @override
  List<Object?> get props => [id, courseId];
}

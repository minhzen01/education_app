import 'package:equatable/equatable.dart';

class VideoEntity extends Equatable {
  const VideoEntity({
    required this.id,
    required this.videoURL,
    required this.courseId,
    required this.uploadTime,
    this.thumbnailIsFile = false,
    this.thumbnail,
    this.title,
    this.tutor,
  });

  factory VideoEntity.empty() {
    return VideoEntity(
      id: '_empty.id',
      videoURL: '_empty.videoURL',
      courseId: '_empty.courseId',
      uploadTime: DateTime.now(),
    );
  }

  final String id;
  final String? thumbnail;
  final String videoURL;
  final String? title;
  final String? tutor;
  final String courseId;
  final DateTime uploadTime;
  final bool thumbnailIsFile;

  @override
  List<Object?> get props => [id];
}

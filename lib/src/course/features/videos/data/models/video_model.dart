import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video_entity.dart';

class VideoModel extends VideoEntity {
  const VideoModel({
    required super.id,
    required super.videoURL,
    required super.courseId,
    required super.uploadTime,
    super.thumbnailIsFile = false,
    super.thumbnail,
    super.title,
    super.tutor,
  });

  factory VideoModel.empty() {
    return VideoModel(
      id: '_empty.id',
      videoURL: '_empty.videoURL',
      courseId: '_empty.courseId',
      uploadTime: DateTime.now(),
    );
  }

  factory VideoModel.fromMap(DataMap map) {
    return VideoModel(
      id: map['id'] as String,
      videoURL: map['videoURL'] as String,
      courseId: map['courseId'] as String,
      uploadTime: (map['uploadTime'] as Timestamp).toDate(),
      thumbnail: map['thumbnail'] as String?,
      title: map['title'] as String?,
      tutor: map['tutor'] as String?,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'thumbnail': thumbnail,
      'videoURL': videoURL,
      'title': title,
      'tutor': tutor,
      'courseId': courseId,
      'uploadTime': FieldValue.serverTimestamp(),
      // 'uploadTime': uploadTime,
      // 'thumbnailIsFile': thumbnailIsFile,
    };
  }

  VideoModel copyWith({
    String? id,
    String? thumbnail,
    String? videoURL,
    String? title,
    String? tutor,
    String? courseId,
    DateTime? uploadTime,
    bool? thumbnailIsFile,
  }) {
    return VideoModel(
      id: id ?? this.id,
      thumbnail: thumbnail ?? this.thumbnail,
      videoURL: videoURL ?? this.videoURL,
      title: title ?? this.title,
      tutor: tutor ?? this.tutor,
      courseId: courseId ?? this.courseId,
      uploadTime: uploadTime ?? this.uploadTime,
      thumbnailIsFile: thumbnailIsFile ?? this.thumbnailIsFile,
    );
  }
}

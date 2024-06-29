import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video_entity.dart';

abstract class VideoRepository {
  const VideoRepository();

  ResultFuture<List<VideoEntity>> getVideos(String courseId);

  ResultFuture<void> addVideo(VideoEntity videoEntity);
}

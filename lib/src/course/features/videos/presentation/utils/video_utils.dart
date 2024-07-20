import 'package:education_app/core/extensions/string_extensions.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/src/course/features/videos/data/models/video_model.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video_entity.dart';
import 'package:education_app/src/notifications/data/models/notification_model.dart';
import 'package:education_app/src/notifications/domain/entities/notification_entity.dart';
import 'package:education_app/src/notifications/presentation/cubit/notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_metadata/youtube_metadata.dart';

class VideoUtils {
  const VideoUtils._();

  static Future<VideoEntity?> getVideoFromYT(
    BuildContext context, {
    required String url,
  }) async {
    void showSnack(String message) {
      CoreUtils.showSnackBar(context, message);
    }

    try {
      final metadata = await YoutubeMetaData.getData(url);
      if (metadata.thumbnailUrl == null || metadata.title == null || metadata.authorName == null) {
        final missingData = <String>[];
        if (metadata.thumbnailUrl == null) missingData.add('Thumbnail');
        if (metadata.title == null) missingData.add('Title');
        if (metadata.authorName == null) missingData.add('AuthorName');
        var missingDataText = missingData
            .fold(
              '',
              (previousValue, element) => '$previousValue$element, ',
            )
            .trim();
        missingDataText = missingDataText.substring(0, missingDataText.length - 1);
        final message = 'Could not get video data. Please try again.\nThe following data is missing: $missingDataText';
        showSnack(message);
        return null;
      }
      return VideoModel.empty().copyWith(
        thumbnail: metadata.thumbnailUrl,
        videoURL: url,
        title: metadata.title,
        tutor: metadata.authorName,
      );
    } catch (e) {
      showSnack('PLEASE TRY AGAIN\n $e');
      return null;
    }
  }

  static Future<void> playVideo(BuildContext context, String videoURL) async {
    if (videoURL.isYoutubeVideo) {
      if (!await launchUrl(Uri.parse(videoURL), mode: LaunchMode.externalApplication)) {
        // ignore: use_build_context_synchronously
        CoreUtils.showSnackBar(context, 'Could not launch $videoURL');
      } else {
        // context.push(VideoPlayerScreen);
      }
    }
  }

  static void sendNotification({
    required BuildContext context,
    required String title,
    required String body,
    required NotificationCategory category,
  }) {
    context.read<NotificationCubit>().sendNotification(
          NotificationModel.empty().copyWith(
            title: title,
            body: body,
            category: category,
          ),
        );
  }
}

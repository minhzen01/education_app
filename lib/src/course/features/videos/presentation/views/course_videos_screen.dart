import 'package:education_app/core/common/views/loading_view.dart';
import 'package:education_app/core/common/widgets/gradient_background.dart';
import 'package:education_app/core/common/widgets/nested_back_button.dart';
import 'package:education_app/core/common/widgets/not_found_text.dart';
import 'package:education_app/core/common/widgets/video_tile.dart';
import 'package:education_app/core/res/app_colors.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/src/course/domain/entities/course.dart';
import 'package:education_app/src/course/features/videos/presentation/cubit/video_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseVideosScreen extends StatefulWidget {
  const CourseVideosScreen({
    required this.course,
    super.key,
  });

  static const routeName = '/course-videos';

  final Course course;

  @override
  State<CourseVideosScreen> createState() => _CourseVideosScreenState();
}

class _CourseVideosScreenState extends State<CourseVideosScreen> {
  void getVideos() {
    context.read<VideoCubit>().getVideos(widget.course.id);
  }

  @override
  void initState() {
    super.initState();
    getVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const NestedBackButton(),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: GradientBackground(
        image: MediaRes.homeGradientBackground,
        child: BlocConsumer<VideoCubit, VideoState>(
          listener: (context, state) {
            if (state is VideoErrorState) {
              CoreUtils.showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is LoadingVideosState) {
              return const LoadingView();
            } else if ((state is VideosLoadedState && state.videos.isEmpty) || state is VideoErrorState) {
              return NotFoundText(text: 'No videos found for ${widget.course.title}');
            } else if (state is VideosLoadedState) {
              final videos = state.videos..sort((a, b) => b.uploadTime.compareTo(a.uploadTime));
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.course.title} Videos',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${state.videos.length} video(s) found',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.neutralTextColour,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.videos.length,
                        itemBuilder: (context, index) {
                          return VideoTile(
                            video: videos[index],
                            tappable: true,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

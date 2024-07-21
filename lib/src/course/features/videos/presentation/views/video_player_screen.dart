import 'package:chewie/chewie.dart';
import 'package:education_app/core/common/widgets/nested_back_button.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({
    required this.videoURL,
    super.key,
  });

  static const routeName = '/video-player';

  final String videoURL;

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  bool loop = false;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoURL));
    await videoPlayerController.initialize();
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      hideControlsTimer: const Duration(seconds: 5),
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const NestedBackButton(),
        backgroundColor: Colors.transparent,
      ),
      body: chewieController != null && chewieController!.videoPlayerController.value.isInitialized
          ? Chewie(controller: chewieController!)
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

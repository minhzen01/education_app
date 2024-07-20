import 'package:education_app/core/common/widgets/course_picker.dart';
import 'package:education_app/core/common/widgets/info_field.dart';
import 'package:education_app/core/common/widgets/reactive_button.dart';
import 'package:education_app/core/common/widgets/video_tile.dart';
import 'package:education_app/core/extensions/string_extensions.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/src/course/domain/entities/course.dart';
import 'package:education_app/src/course/features/videos/data/models/video_model.dart';
import 'package:education_app/src/course/features/videos/presentation/cubit/video_cubit.dart';
import 'package:education_app/src/course/features/videos/presentation/utils/video_utils.dart';
import 'package:education_app/src/notifications/domain/entities/notification_entity.dart';
import 'package:education_app/src/notifications/presentation/widgets/notification_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;
import 'package:flutter_link_previewer/flutter_link_previewer.dart';

class AddVideoScreen extends StatefulWidget {
  const AddVideoScreen({super.key});

  static const routeName = '/add-video';

  @override
  State<AddVideoScreen> createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {
  final urlController = TextEditingController();
  final authorController = TextEditingController(text: 'zenx');
  final titleController = TextEditingController();
  final courseController = TextEditingController();
  final courseNotifier = ValueNotifier<Course?>(null);

  final formKey = GlobalKey<FormState>();

  VideoModel? video;
  PreviewData? previewData;

  final authorFocusNode = FocusNode();
  final titleFocusNode = FocusNode();
  final urlFocusNode = FocusNode();

  bool getMoreDetails = false;
  bool loading = false;
  bool showingDialog = false;

  bool get isYoutube => urlController.text.trim().isYoutubeVideo;

  bool thumbNailIsFile = false;

  void reset() {
    setState(() {
      urlController.clear();
      authorController.text = 'zenx';
      titleController.clear();
      getMoreDetails = false;
      loading = false;
      video = null;
      previewData = null;
    });
  }

  @override
  void initState() {
    super.initState();
    urlController.addListener(() {
      if (urlController.text.trim().isEmpty) reset();
    });
    authorController.addListener(() {
      video = video?.copyWith(tutor: authorController.text.trim());
    });
    titleController.addListener(() {
      video = video?.copyWith(title: titleController.text.trim());
    });
  }

  Future<void> fetchVideo() async {
    if (urlController.text.trim().isEmpty) return;
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      getMoreDetails = false;
      loading = false;
      thumbNailIsFile = false;
      video = null;
      previewData = null;
    });
    setState(() => loading = true);
    if (isYoutube) {
      video = await VideoUtils.getVideoFromYT(
        context,
        url: urlController.text.trim(),
      ) as VideoModel?;
    }
    setState(() => loading = false);
  }

  @override
  void dispose() {
    urlController.dispose();
    authorController.dispose();
    titleController.dispose();
    courseController.dispose();
    courseNotifier.dispose();
    authorFocusNode.dispose();
    titleFocusNode.dispose();
    urlFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationWrapper(
      onNotificationSent: () {
        Navigator.of(context).pop();
      },
      child: BlocListener<VideoCubit, VideoState>(
        listener: (context, state) {
          if (showingDialog == true) {
            Navigator.of(context).pop();
            showingDialog = false;
          }
          if (state is AddingVideoState) {
            CoreUtils.showLoadingDialog(context);
            showingDialog = true;
          } else if (state is VideoErrorState) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is VideoAddedState) {
            CoreUtils.showSnackBar(context, 'Video added successfully');
            VideoUtils.sendNotification(
              context: context,
              title: 'New ${courseNotifier.value!.title} video',
              body: 'A new video has been added for ${courseNotifier.value!.title}',
              category: NotificationCategory.VIDEO,
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Add Video'),
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            shrinkWrap: true,
            children: [
              Form(
                key: formKey,
                child: CoursePicker(
                  controller: courseController,
                  notifier: courseNotifier,
                ),
              ),
              const SizedBox(height: 20),
              InfoField(
                controller: urlController,
                hintText: 'Enter video URL',
                onEditingComplete: fetchVideo,
                focusNode: urlFocusNode,
                onTapOutside: (_) => urlFocusNode.unfocus(),
                autoFocus: true,
                keyboardType: TextInputType.url,
              ),
              ListenableBuilder(
                listenable: urlController,
                builder: (_, __) {
                  return Column(
                    children: [
                      if (urlController.text.trim().isNotEmpty) ...[
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: fetchVideo,
                          child: const Text('Fetch Video'),
                        ),
                      ],
                    ],
                  );
                },
              ),
              if (loading && !isYoutube)
                LinkPreview(
                  onPreviewDataFetched: (data) async {
                    setState(() {
                      thumbNailIsFile = false;
                      video = VideoModel.empty().copyWith(
                        thumbnail: data.image?.url,
                        videoURL: urlController.text.trim(),
                        title: data.title ?? 'No title',
                      );
                      if (data.image?.url != null) loading = false;
                      getMoreDetails = true;
                      titleController.text = data.title ?? '';
                      loading = false;
                    });
                  },
                  previewData: previewData,
                  text: '',
                  width: 0,
                ),
              if (video != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: VideoTile(
                    video: video!,
                    isFile: thumbNailIsFile,
                    uploadTimePrefix: '~',
                  ),
                ),
              if (getMoreDetails) ...[
                InfoField(
                  controller: authorController,
                  keyboardType: TextInputType.name,
                  autoFocus: true,
                  focusNode: authorFocusNode,
                  labelText: 'Tutor Name',
                  onEditingComplete: () {
                    setState(() {});
                    titleFocusNode.requestFocus();
                  },
                ),
                InfoField(
                  controller: titleController,
                  focusNode: titleFocusNode,
                  labelText: 'Video Title',
                  onEditingComplete: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    setState(() {});
                  },
                ),
              ],
              const SizedBox(height: 20),
              Center(
                child: ReactiveButton(
                  disabled: video == null,
                  loading: loading,
                  text: 'Submit',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (courseNotifier.value == null) {
                        CoreUtils.showSnackBar(context, 'Please pick a course');
                        return;
                      }
                      if (courseNotifier.value != null && video != null && video!.tutor == null && authorController.text.trim().isNotEmpty) {
                        video = video!.copyWith(
                          tutor: authorController.text.trim(),
                        );
                      }
                      if (video != null && video!.tutor != null && video!.title != null && video!.title!.isNotEmpty) {
                        video = video?.copyWith(
                          thumbnailIsFile: thumbNailIsFile,
                          courseId: courseNotifier.value!.id,
                          uploadTime: DateTime.now(),
                        );
                        context.read<VideoCubit>().addVideo(video!);
                      } else  {
                        CoreUtils.showSnackBar(context, 'Please fill all fields');
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

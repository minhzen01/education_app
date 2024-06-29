part of 'video_cubit.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object?> get props => [];
}

class VideoInitialState extends VideoState {
  const VideoInitialState();
}

class AddingVideoState extends VideoState {
  const AddingVideoState();
}

class VideoAddedState extends VideoState {
  const VideoAddedState();
}

class LoadingVideosState extends VideoState {
  const LoadingVideosState();
}

class VideosLoadedState extends VideoState {
  const VideosLoadedState({required this.videos});

  final List<VideoEntity> videos;

  @override
  List<Object?> get props => [videos];
}

class VideoErrorState extends VideoState {
  const VideoErrorState({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

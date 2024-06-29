import 'package:bloc/bloc.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video_entity.dart';
import 'package:education_app/src/course/features/videos/domain/usecases/add_video_use_case.dart';
import 'package:education_app/src/course/features/videos/domain/usecases/get_videos_use_case.dart';
import 'package:equatable/equatable.dart';

part 'video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoCubit(
    this._addVideoUseCase,
    this._getVideosUseCase,
  ) : super(const VideoInitialState());

  final AddVideoUseCase _addVideoUseCase;
  final GetVideosUseCase _getVideosUseCase;

  Future<void> addVideo(VideoEntity videoEntity) async {
    emit(const AddingVideoState());
    final result = await _addVideoUseCase.call(videoEntity);
    result.fold(
      (failure) => emit(VideoErrorState(message: failure.errorMessage)),
      (success) => emit(const VideoAddedState()),
    );
  }

  Future<void> getVideos(String courseId) async {
    emit(const LoadingVideosState());
    final result = await _getVideosUseCase.call(courseId);
    result.fold(
      (failure) => emit(VideoErrorState(message: failure.errorMessage)),
      (success) => emit(VideosLoadedState(videos: success)),
    );
  }
}

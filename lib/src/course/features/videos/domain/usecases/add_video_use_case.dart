import 'package:education_app/core/usecases/use_case_with_params.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/videos/domain/entities/video_entity.dart';
import 'package:education_app/src/course/features/videos/domain/repositories/video_repository.dart';

class AddVideoUseCase extends UseCaseWithParams<void, VideoEntity> {
  const AddVideoUseCase(this._repository);

  final VideoRepository _repository;

  @override
  ResultFuture<void> call(VideoEntity params) async {
    return _repository.addVideo(params);
  }
}

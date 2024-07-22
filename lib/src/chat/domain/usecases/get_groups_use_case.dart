import 'package:education_app/core/usecases/stream_use_case_without_params.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/chat/domain/entities/group.dart';
import 'package:education_app/src/chat/domain/repositories/chat_repository.dart';

class GetGroupsUseCase extends StreamUseCaseWithoutParams<List<Group>> {
  const GetGroupsUseCase(this._repo);

  final ChatRepository _repo;

  @override
  ResultStream<List<Group>> call() => _repo.getGroups();
}

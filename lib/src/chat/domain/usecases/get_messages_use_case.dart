import 'package:education_app/core/usecases/stream_use_case_with_params.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/chat/domain/entities/message.dart';
import 'package:education_app/src/chat/domain/repositories/chat_repository.dart';

class GetMessagesUseCase extends StreamUseCaseWithParams<List<Message>, String> {
  const GetMessagesUseCase(this._repo);

  final ChatRepository _repo;

  @override
  ResultStream<List<Message>> call(String params) => _repo.getMessages(params);
}

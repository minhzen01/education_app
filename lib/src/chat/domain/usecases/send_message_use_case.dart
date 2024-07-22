import 'package:education_app/core/usecases/use_case_with_params.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/chat/domain/entities/message.dart';
import 'package:education_app/src/chat/domain/repositories/chat_repository.dart';

class SendMessageUseCase extends UseCaseWithParams<void, Message> {
  const SendMessageUseCase(this._repo);

  final ChatRepository _repo;

  @override
  ResultFuture<void> call(Message params) async => _repo.sendMessage(params);
}

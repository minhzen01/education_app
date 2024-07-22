import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/authentication/domain/entities/user_entity.dart';
import 'package:education_app/src/chat/domain/entities/group.dart';
import 'package:education_app/src/chat/domain/entities/message.dart';

abstract class ChatRepository {
  const ChatRepository();

  ResultFuture<void> sendMessage(Message message);

  ResultStream<List<Group>> getGroups();

  ResultStream<List<Message>> getMessages(String groupId);

  ResultFuture<void> joinGroup({
    required String groupId,
    required String userId,
  });

  ResultFuture<void> leaveGroup({
    required String groupId,
    required String userId,
  });

  ResultFuture<UserEntity> getUserById(String userId);
}

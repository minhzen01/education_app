import 'package:education_app/core/usecases/use_case_with_params.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/chat/domain/repositories/chat_repository.dart';
import 'package:equatable/equatable.dart';

class LeaveGroupUseCase extends UseCaseWithParams<void, LeaveGroupParams> {
  const LeaveGroupUseCase(this._repo);

  final ChatRepository _repo;

  @override
  ResultFuture<void> call(LeaveGroupParams params) => _repo.leaveGroup(
        groupId: params.groupId,
        userId: params.userId,
      );
}

class LeaveGroupParams extends Equatable {
  const LeaveGroupParams({required this.groupId, required this.userId});

  const LeaveGroupParams.empty()
      : groupId = '',
        userId = '';

  final String groupId;
  final String userId;

  @override
  List<String> get props => [groupId, userId];
}

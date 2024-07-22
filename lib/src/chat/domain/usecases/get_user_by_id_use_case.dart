import 'package:education_app/core/usecases/use_case_with_params.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/authentication/domain/entities/user_entity.dart';
import 'package:education_app/src/chat/domain/repositories/chat_repository.dart';

class GetUserByIdUseCase extends UseCaseWithParams<UserEntity, String> {
  const GetUserByIdUseCase(this._repo);

  final ChatRepository _repo;

  @override
  ResultFuture<UserEntity> call(String params) => _repo.getUserById(params);
}

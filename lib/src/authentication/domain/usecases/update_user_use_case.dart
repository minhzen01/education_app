import 'package:education_app/core/usecases/use_case_with_params.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/authentication/domain/entities/update_user_params.dart';
import 'package:education_app/src/authentication/domain/repositories/auth_repository.dart';

class UpdateUserUseCase extends UseCaseWithParams<void, UpdateUserParams> {
  const UpdateUserUseCase(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<void> call(UpdateUserParams params) async {
    return _repository.updateUser(
      action: params.action,
      userData: params.userData,
    );
  }
}

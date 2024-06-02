import 'package:education_app/core/usecases/use_case_with_params.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/authentication/domain/entities/sign_in_params.dart';
import 'package:education_app/src/authentication/domain/entities/user_entity.dart';
import 'package:education_app/src/authentication/domain/repositories/auth_repository.dart';

class SignInUseCase extends UseCaseWithParams<UserEntity, SignInParams> {
  const SignInUseCase(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<UserEntity> call(SignInParams params) async {
    return _repository.signIn(
      email: params.email,
      password: params.password,
    );
  }
}

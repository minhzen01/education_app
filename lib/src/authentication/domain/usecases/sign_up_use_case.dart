import 'package:education_app/core/usecases/use_case_with_params.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/authentication/domain/entities/sign_up_params.dart';
import 'package:education_app/src/authentication/domain/repositories/auth_repository.dart';

class SignUpUseCase extends UseCaseWithParams<void, SignUpParams> {
  const SignUpUseCase(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<void> call(SignUpParams params) async {
    return _repository.signUp(
      email: params.email,
      fullName: params.fullName,
      password: params.password,
    );
  }
}

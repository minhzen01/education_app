import 'package:education_app/core/usecases/use_case_with_params.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/authentication/domain/repositories/auth_repository.dart';

class ForgotPasswordUseCase extends UseCaseWithParams<void, String> {
  const ForgotPasswordUseCase(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<void> call(String params) async {
    return _repository.forgotPassword(email: params);
  }
}

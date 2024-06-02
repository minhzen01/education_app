import 'package:education_app/core/usecases/use_case_without_params.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/on_boarding/domain/repositories/on_boarding_repository.dart';

class CheckIfUserIsFirstTimerUseCase extends UseCaseWithoutParams<bool> {
  const CheckIfUserIsFirstTimerUseCase(this._repository);

  final OnBoardingRepository _repository;

  @override
  ResultFuture<bool> call() async {
    return _repository.checkIfUserIsFirstTimer();
  }
}

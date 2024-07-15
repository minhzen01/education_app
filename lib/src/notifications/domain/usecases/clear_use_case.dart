import 'package:education_app/core/usecases/use_case_with_params.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/notifications/domain/repositories/notification_repository.dart';

class ClearUseCase extends UseCaseWithParams<void, String> {
  const ClearUseCase(this._repository);

  final NotificationRepository _repository;

  @override
  ResultFuture<void> call(String params) async {
    return _repository.clear(params);
  }
}

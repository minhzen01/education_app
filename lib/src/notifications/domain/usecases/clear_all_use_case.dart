import 'package:education_app/core/usecases/use_case_without_params.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/notifications/domain/repositories/notification_repository.dart';

class ClearAllUseCase extends UseCaseWithoutParams<void> {
  const ClearAllUseCase(this._repository);

  final NotificationRepository _repository;

  @override
  ResultFuture<void> call() async {
    return _repository.clearAll();
  }
}

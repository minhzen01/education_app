import 'package:education_app/core/usecases/use_case_with_params.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/notifications/domain/entities/notification_entity.dart';
import 'package:education_app/src/notifications/domain/repositories/notification_repository.dart';

class SendNotificationUseCase extends UseCaseWithParams<void, NotificationEntity> {
  const SendNotificationUseCase(this._repository);

  final NotificationRepository _repository;

  @override
  ResultFuture<void> call(NotificationEntity params) async {
    return _repository.sendNotification(params);
  }
}

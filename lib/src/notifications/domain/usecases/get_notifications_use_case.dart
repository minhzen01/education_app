import 'package:education_app/core/usecases/stream_use_case_without_params.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/notifications/domain/entities/notification_entity.dart';
import 'package:education_app/src/notifications/domain/repositories/notification_repository.dart';

class GetNotificationsUseCase extends StreamUseCaseWithoutParams<List<NotificationEntity>> {
  const GetNotificationsUseCase(this._repository);

  final NotificationRepository _repository;

  @override
  ResultStream<List<NotificationEntity>> call() {
    return _repository.getNotifications();
  }
}

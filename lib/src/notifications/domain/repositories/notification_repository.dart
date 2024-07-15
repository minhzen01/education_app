import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/notifications/domain/entities/notification_entity.dart';

abstract class NotificationRepository {
  const NotificationRepository();

  ResultFuture<void> markAsRead(String notificationId);

  ResultFuture<void> clearAll();

  ResultFuture<void> clear(String notificationId);

  ResultFuture<void> sendNotification(NotificationEntity notification);

  ResultStream<List<NotificationEntity>> getNotifications();
}

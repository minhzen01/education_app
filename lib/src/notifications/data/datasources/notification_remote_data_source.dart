import 'package:education_app/src/notifications/data/models/notification_model.dart';
import 'package:education_app/src/notifications/domain/entities/notification_entity.dart';

abstract class NotificationRemoteDataSource {
  const NotificationRemoteDataSource();

  Future<void> markAsRead(String notificationId);

  Future<void> clearAll();

  Future<void> clear(String notificationId);

  Future<void> sendNotification(NotificationEntity notification);

  Stream<List<NotificationModel>> getNotifications();
}

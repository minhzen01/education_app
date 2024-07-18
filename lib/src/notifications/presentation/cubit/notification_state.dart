part of 'notification_cubit.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

class ClearingNotificationsState extends NotificationState {
  const ClearingNotificationsState();
}

class NotificationInitialState extends NotificationState {
  const NotificationInitialState();
}

class NotificationErrorState extends NotificationState {
  const NotificationErrorState({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

class SendingNotificationState extends NotificationState {
  const SendingNotificationState();
}

class NotificationSentState extends NotificationState {
  const NotificationSentState();
}

class GettingNotificationsState extends NotificationState {
  const GettingNotificationsState();
}

class NotificationsLoaded extends NotificationState {
  const NotificationsLoaded({required this.notifications});

  final List<NotificationEntity> notifications;

  @override
  List<Object?> get props => [notifications];
}

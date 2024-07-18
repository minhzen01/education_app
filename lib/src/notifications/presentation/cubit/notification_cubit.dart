import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failures/failure.dart';
import 'package:education_app/src/notifications/domain/entities/notification_entity.dart';
import 'package:education_app/src/notifications/domain/usecases/clear_all_use_case.dart';
import 'package:education_app/src/notifications/domain/usecases/clear_use_case.dart';
import 'package:education_app/src/notifications/domain/usecases/get_notifications_use_case.dart';
import 'package:education_app/src/notifications/domain/usecases/mark_as_read_use_case.dart';
import 'package:education_app/src/notifications/domain/usecases/send_notification_use_case.dart';
import 'package:equatable/equatable.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(
    this._clearUseCase,
    this._clearAllUseCase,
    this._getNotificationsUseCase,
    this._markAsReadUseCase,
    this._sendNotificationUseCase,
  ) : super(const NotificationInitialState());

  final ClearUseCase _clearUseCase;
  final ClearAllUseCase _clearAllUseCase;
  final GetNotificationsUseCase _getNotificationsUseCase;
  final MarkAsReadUseCase _markAsReadUseCase;
  final SendNotificationUseCase _sendNotificationUseCase;

  Future<void> clear(String notificationId) async {
    emit(const ClearingNotificationsState());
    final result = await _clearUseCase.call(notificationId);
    result.fold(
      (failure) => emit(NotificationErrorState(message: failure.errorMessage)),
      (success) => emit(const NotificationInitialState()),
    );
  }

  Future<void> clearAll() async {
    emit(const ClearingNotificationsState());
    final result = await _clearAllUseCase.call();
    result.fold(
      (failure) => emit(NotificationErrorState(message: failure.errorMessage)),
      (success) => emit(const NotificationInitialState()),
    );
  }

  Future<void> markAsRead(String notificationId) async {
    final result = await _markAsReadUseCase.call(notificationId);
    result.fold(
      (failure) => emit(NotificationErrorState(message: failure.errorMessage)),
      (success) => emit(const NotificationInitialState()),
    );
  }

  Future<void> sendNotification(NotificationEntity notification) async {
    emit(const SendingNotificationState());
    final result = await _sendNotificationUseCase.call(notification);
    result.fold(
      (failure) => emit(NotificationErrorState(message: failure.errorMessage)),
      (success) => emit(const NotificationSentState()),
    );
  }

  void getNotifications() {
    emit(const GettingNotificationsState());
    StreamSubscription<Either<Failure, List<NotificationEntity>>>? subscription;

    subscription = _getNotificationsUseCase.call().listen(
      (result) {
        result.fold(
          (failure) {
            emit(NotificationErrorState(message: failure.errorMessage));
            subscription?.cancel();
          },
          (success) => emit(NotificationsLoaded(notifications: success)),
        );
      },
      onError: (dynamic error) {
        emit(NotificationErrorState(message: error.toString()));
        subscription?.cancel();
      },
      onDone: () {
        subscription?.cancel();
      },
    );
  }
}

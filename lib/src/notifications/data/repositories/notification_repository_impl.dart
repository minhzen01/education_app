import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions/server_exception.dart';
import 'package:education_app/core/errors/failures/failure.dart';
import 'package:education_app/core/errors/failures/server_failure.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/notifications/data/datasources/notification_remote_data_source.dart';
import 'package:education_app/src/notifications/data/models/notification_model.dart';
import 'package:education_app/src/notifications/domain/entities/notification_entity.dart';
import 'package:education_app/src/notifications/domain/repositories/notification_repository.dart';
import 'package:flutter/foundation.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  const NotificationRepositoryImpl(this._remoteDataSource);

  final NotificationRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<void> clear(String notificationId) async {
    try {
      await _remoteDataSource.clear(notificationId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> clearAll() async {
    try {
      await _remoteDataSource.clearAll();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultStream<List<NotificationEntity>> getNotifications() {
    return _remoteDataSource.getNotifications().transform(
          StreamTransformer<List<NotificationModel>, Either<Failure, List<NotificationEntity>>>.fromHandlers(
            handleData: (notifications, sink) {
              sink.add(Right(notifications));
            },
            handleError: (error, stackTrace, sink) {
              debugPrint(stackTrace.toString());
              if (error is ServerException) {
                sink.add(Left(ServerFailure.fromException(error)));
              } else {
                sink.add(Left(ServerFailure(message: error.toString(), statusCode: 505)));
              }
            },
          ),
        );
  }

  @override
  ResultFuture<void> markAsRead(String notificationId) async {
    try {
      await _remoteDataSource.markAsRead(notificationId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> sendNotification(NotificationEntity notification) async {
    try {
      await _remoteDataSource.sendNotification(notification);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}

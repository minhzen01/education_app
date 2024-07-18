import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/errors/exceptions/server_exception.dart';
import 'package:education_app/core/utils/datasource_utils.dart';
import 'package:education_app/src/notifications/data/datasources/notification_remote_data_source.dart';
import 'package:education_app/src/notifications/data/models/notification_model.dart';
import 'package:education_app/src/notifications/domain/entities/notification_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  const NotificationRemoteDataSourceImpl(this._firestore, this._auth);

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  @override
  Future<void> clear(String notificationId) async {
    try {
      await DatasourceUtils.authorizeUser(_auth);
      await _firestore.collection('users').doc(_auth.currentUser!.uid).collection('notifications').doc(notificationId).delete();
    } on FirebaseException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? 'Unknown error occurred',
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(
        statusCode: '505',
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> clearAll() async {
    try {
      await DatasourceUtils.authorizeUser(_auth);

      final query = _firestore.collection('users').doc(_auth.currentUser!.uid).collection('notifications');

      return _deleteNotificationsByQuery(query);
    } on FirebaseException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? 'Unknown error occurred',
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(
        statusCode: '505',
        message: e.toString(),
      );
    }
  }

  @override
  Stream<List<NotificationModel>> getNotifications() {
    try {
      DatasourceUtils.authorizeUser(_auth);
      final notificationsStream = _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notifications')
          .orderBy('sentAt', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((e) => NotificationModel.fromMap(e.data())).toList());
      return notificationsStream.handleError(
        (dynamic error) {
          if (error is FirebaseException) {
            throw ServerException(
              statusCode: error.code,
              message: error.message ?? 'Unknown error occurred',
            );
          }
          throw ServerException(statusCode: '505', message: error.toString());
        },
      );
    } on FirebaseException catch (e) {
      return Stream.error(
        ServerException(
          statusCode: e.code,
          message: e.message ?? 'Unknown error occurred',
        ),
      );
    } on ServerException catch (e) {
      return Stream.error(e);
    } catch (e) {
      return Stream.error(
        ServerException(
          statusCode: '505',
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    try {
      await DatasourceUtils.authorizeUser(_auth);
      await _firestore.collection('users').doc(_auth.currentUser!.uid).collection('notifications').doc(notificationId).update({'seen': true});
    } on FirebaseException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? 'Unknown error occurred',
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(
        statusCode: '505',
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> sendNotification(NotificationEntity notification) async {
    try {
      await DatasourceUtils.authorizeUser(_auth);
      // send notify to every user's notification collection.
      final users = await _firestore.collection('users').get();

      if (users.docs.length > 500) {
        for (var i = 0; i < users.docs.length; i += 500) {
          final batch = _firestore.batch();
          final end = i + 500;
          final usersBatch = users.docs.sublist(i, end > users.docs.length ? users.docs.length : end);
          for (final user in usersBatch) {
            final newNotificationRef = user.reference.collection('notifications').doc();
            batch.set(newNotificationRef, (notification as NotificationModel).copyWith(id: newNotificationRef.id).toMap());
          }
          await batch.commit();
        }
      } else {
        final batch = _firestore.batch();
        for (final user in users.docs) {
          final newNotificationRef = user.reference.collection('notifications').doc();
          batch.set(newNotificationRef, (notification as NotificationModel).copyWith(id: newNotificationRef.id).toMap());
        }
        await batch.commit();
      }
    } on FirebaseException catch (e) {
      throw ServerException(
        statusCode: e.code,
        message: e.message ?? 'Unknown error occurred',
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(
        statusCode: '505',
        message: e.toString(),
      );
    }
  }

  Future<void> _deleteNotificationsByQuery(Query query) async {
    final notifications = await query.get();
    if (notifications.docs.length > 500) {
      for (var i = 0; i < notifications.docs.length; i += 500) {
        final batch = _firestore.batch();
        final end = i + 500;
        final notificationBatch = notifications.docs.sublist(i, end > notifications.docs.length ? notifications.docs.length : end);
        for (final notification in notificationBatch) {
          batch.delete(notification.reference);
        }
        await batch.commit();
      }
    } else {
      final batch = _firestore.batch();
      for (final notification in notifications.docs) {
        batch.delete(notification.reference);
      }
      await batch.commit();
    }
  }
}

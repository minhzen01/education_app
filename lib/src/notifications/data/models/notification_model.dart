import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/extensions/enum_extensions.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/notifications/domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.id,
    required super.title,
    required super.body,
    required super.category,
    required super.seen,
    required super.sentAt,
  });

  factory NotificationModel.fromMap(DataMap map) {
    return NotificationModel(
      id: map['id'] as String,
      title: map['title:'] as String,
      body: map['body'] as String,
      category: (map['category'] as String).toNotificationCategory,
      seen: map['seen'] as bool,
      sentAt: (map['sentAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  factory NotificationModel.empty() {
    return NotificationModel(
      id: '_empty.id',
      title: '_empty.title',
      body: '_empty.body',
      category: NotificationCategory.NONE,
      seen: false,
      sentAt: DateTime.now(),
    );
  }

  NotificationModel copyWith({
    String? id,
    String? title,
    String? body,
    NotificationCategory? category,
    bool? seen,
    DateTime? sentAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      category: category ?? this.category,
      seen: seen ?? this.seen,
      sentAt: sentAt ?? this.sentAt,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'category': category.value,
      'seen': seen,
      'sentAt': FieldValue.serverTimestamp(),
    };
  }
}

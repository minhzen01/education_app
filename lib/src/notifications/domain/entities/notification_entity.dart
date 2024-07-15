import 'package:education_app/core/res/media_res.dart';
import 'package:equatable/equatable.dart';

// ignore_for_file: constant_identifier_names

enum NotificationCategory {
  TEST(value: 'test', image: MediaRes.test),
  VIDEO(value: 'video', image: MediaRes.video),
  MATERIAL(value: 'material', image: MediaRes.material),
  COURSE(value: 'course', image: MediaRes.course),
  NONE(value: 'none', image: MediaRes.course);

  const NotificationCategory({
    required this.value,
    required this.image,
  });

  final String value;
  final String image;
}

class NotificationEntity extends Equatable {
  const NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.category,
    required this.seen,
    required this.sentAt,
  });

  factory NotificationEntity.empty() {
    return NotificationEntity(
      id: '_empty.id',
      title: '_empty.title',
      body: '_empty.body',
      category: NotificationCategory.NONE,
      seen: false,
      sentAt: DateTime.now(),
    );
  }

  final String id;
  final String title;
  final String body;
  final NotificationCategory category;
  final bool seen;
  final DateTime sentAt;

  @override
  List<Object?> get props => [id];

}

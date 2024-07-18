import 'package:education_app/core/common/widgets/time_text.dart';
import 'package:education_app/src/notifications/domain/entities/notification_entity.dart';
import 'package:education_app/src/notifications/presentation/cubit/notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    required this.entity,
    super.key,
  });

  final NotificationEntity entity;

  @override
  Widget build(BuildContext context) {
    if (!entity.seen) {
      context.read<NotificationCubit>().markAsRead(entity.id);
    }
    return Dismissible(
      key: Key(entity.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) {
        context.read<NotificationCubit>().clear(entity.id);
      },
      child: ListTile(
        leading: CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage(entity.category.image),
          backgroundColor: Colors.transparent,
        ),
        title: Text(
          entity.title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        subtitle: TimeText(time: entity.sentAt),
      ),
    );
  }
}

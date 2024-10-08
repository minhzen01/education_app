import 'package:audioplayers/audioplayers.dart';
import 'package:badges/badges.dart';
import 'package:education_app/core/common/app/providers/notifications_notifier.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/services/injection_container.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/src/notifications/presentation/cubit/notification_cubit.dart';
import 'package:education_app/src/notifications/presentation/views/notification_screen.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class NotificationBell extends StatefulWidget {
  const NotificationBell({super.key});

  @override
  State<NotificationBell> createState() => _NotificationBellState();
}

class _NotificationBellState extends State<NotificationBell> {
  final newNotificationListenable = ValueNotifier<bool>(false);
  int? notificationCount;
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().getNotifications();
    newNotificationListenable.addListener(
      () {
        if (newNotificationListenable.value) {
          if (!context.read<NotificationsNotifier>().muteNotifications) {
            player.play(AssetSource('sounds/notification.mp3'));
          }
          newNotificationListenable.value = false;
        }
      },
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationCubit, NotificationState>(
      listener: (context, state) {
        if (state is NotificationsLoaded) {
          if (notificationCount != null) {
            if (notificationCount! < state.notifications.length) {
              newNotificationListenable.value = true;
              notificationCount = state.notifications.length;
            }
          }
          notificationCount = state.notifications.length;
        } else if (state is NotificationErrorState) {
          CoreUtils.showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is NotificationsLoaded) {
          final unseenNotificationsLength = state.notifications.where((e) => !e.seen).length;
          final showBadge = unseenNotificationsLength > 0;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                context.push(
                  BlocProvider.value(
                    value: sl<NotificationCubit>(),
                    child: const NotificationScreen(),
                  ),
                );
              },
              child: Badge(
                showBadge: showBadge,
                position: BadgePosition.topEnd(end: -1),
                badgeContent: Text(
                  unseenNotificationsLength.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                ),
                child: const Icon(IconlyLight.notification),
              ),
            ),
          );
        }
        return const Padding(
          padding: EdgeInsets.only(right: 8),
          child: Icon(IconlyLight.notification),
        );
      },
    );
  }
}

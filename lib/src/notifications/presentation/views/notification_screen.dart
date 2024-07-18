import 'package:badges/badges.dart';
import 'package:education_app/core/common/views/loading_view.dart';
import 'package:education_app/core/common/widgets/nested_back_button.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/src/notifications/presentation/cubit/notification_cubit.dart';
import 'package:education_app/src/notifications/presentation/widgets/no_notifications.dart';
import 'package:education_app/src/notifications/presentation/widgets/notification_options.dart';
import 'package:education_app/src/notifications/presentation/widgets/notification_tile.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: false,
        leading: const NestedBackButton(),
        actions: const [
          NotificationOptions(),
        ],
      ),
      body: BlocConsumer<NotificationCubit, NotificationState>(
        listener: (context, state) {
          if (state is NotificationErrorState) {
            CoreUtils.showSnackBar(context, state.message);
            context.pop();
          }
        },
        builder: (context, state) {
          if (state is GettingNotificationsState || state is ClearingNotificationsState) {
            return const LoadingView();
          } else if (state is NotificationsLoaded && state.notifications.isEmpty) {
            return const NoNotifications();
          } else if (state is NotificationsLoaded && state.notifications.isNotEmpty) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final notification = state.notifications[index];
                return Badge(
                  showBadge: !notification.seen,
                  position: BadgePosition.topEnd(top: 30, end: 20),
                  child: NotificationTile(entity: notification),
                  // child: NotificationTile(notification),
                );
              },
              itemCount: state.notifications.length,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

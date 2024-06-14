import 'dart:async';
import 'package:education_app/core/common/widgets/popup_item.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/res/app_colors.dart';
import 'package:education_app/core/services/injection_container.dart';
import 'package:education_app/src/authentication/presentation/bloc/auth_bloc.dart';
import 'package:education_app/src/profile/presentation/views/edit_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

// ignore_for_file: use_build_context_synchronously

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Account',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 24,
        ),
      ),
      actions: [
        PopupMenuButton(
          offset: const Offset(0, 50),
          surfaceTintColor: Colors.white,
          icon: const Icon(Icons.more_horiz),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          itemBuilder: (_) {
            return [
              PopupMenuItem<void>(
                child: const PopupItem(
                  title: 'Edit Profile',
                  icon: Icon(
                    Icons.edit_outlined,
                    color: AppColors.neutralTextColour,
                  ),
                ),
                onTap: () => context.push(
                  BlocProvider(
                    create: (_) => sl<AuthBloc>(),
                    child: const EditProfileScreen(),
                  ),
                ),
              ),
              const PopupMenuItem<void>(
                child: PopupItem(
                  title: 'Notification',
                  icon: Icon(
                    IconlyLight.notification,
                    color: AppColors.neutralTextColour,
                  ),
                ),
              ),
              const PopupMenuItem<void>(
                child: PopupItem(
                  title: 'Help',
                  icon: Icon(
                    Icons.help_outline_outlined,
                    color: AppColors.neutralTextColour,
                  ),
                ),
              ),
              PopupMenuItem<void>(
                padding: EdgeInsets.zero,
                height: 1,
                child: Divider(height: 1, color: Colors.grey.shade300, endIndent: 16, indent: 16),
              ),
              PopupMenuItem<void>(
                child: const PopupItem(
                  title: 'Logout',
                  icon: Icon(
                    Icons.logout_rounded,
                    color: Colors.black,
                  ),
                ),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  unawaited(Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false));
                },
              ),
            ];
          },
        ),
      ],
    );
  }
}

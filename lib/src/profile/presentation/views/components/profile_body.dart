import 'package:education_app/core/common/app/providers/user_provider.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/res/app_colors.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/core/services/injection_container.dart';
import 'package:education_app/src/course/features/exams/presentation/views/add_exam_screen.dart';
import 'package:education_app/src/course/features/materials/presentation/views/add_materials_screen.dart';
import 'package:education_app/src/course/features/videos/presentation/views/add_video_screen.dart';
import 'package:education_app/src/course/presentation/cubit/course_cubit.dart';
import 'package:education_app/src/course/presentation/views/widgets/add_course_sheet.dart';
import 'package:education_app/src/notifications/presentation/cubit/notification_cubit.dart';
import 'package:education_app/src/profile/presentation/views/widgets/admin_button.dart';
import 'package:education_app/src/profile/presentation/views/widgets/user_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, provider, __) {
        final user = provider.user;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: UserInfoCard(
                    infoThemeColor: AppColors.physicsTileColour,
                    infoIcon: const Icon(
                      IconlyLight.document,
                      color: Color(0xFF767DFF),
                      size: 24,
                    ),
                    infoTitle: 'Courses',
                    infoValue: user!.enrolledCourseIds.length.toString(),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: UserInfoCard(
                    infoThemeColor: AppColors.languageTileColour,
                    infoIcon: Image.asset(
                      MediaRes.scoreboard,
                      height: 24,
                      width: 24,
                    ),
                    infoTitle: 'Score',
                    infoValue: user.points.toString(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: UserInfoCard(
                    infoThemeColor: AppColors.biologyTileColour,
                    infoIcon: const Icon(
                      IconlyLight.user,
                      color: Color(0xFF56AEFF),
                      size: 24,
                    ),
                    infoTitle: 'Followers',
                    infoValue: user.followers.length.toString(),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: UserInfoCard(
                    infoThemeColor: AppColors.chemistryTileColour,
                    infoIcon: const Icon(
                      IconlyLight.user,
                      color: Color(0xFFFF84AA),
                      size: 24,
                    ),
                    infoTitle: 'Following',
                    infoValue: user.following.length.toString(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            if (context.currentUser!.isAdmin) ...[
              AdminButton(
                label: 'Add Course',
                icon: IconlyLight.paper_upload,
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    backgroundColor: Colors.white,
                    isScrollControlled: true,
                    showDragHandle: true,
                    elevation: 0,
                    useSafeArea: true,
                    builder: (_) {
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider(create: (_) => sl<CourseCubit>()),
                          BlocProvider(create: (_) => sl<NotificationCubit>()),
                        ],
                        child: const AddCourseSheet(),
                      );
                    },
                  );
                },
              ),
              AdminButton(
                label: 'Add Video',
                icon: IconlyLight.video,
                onPressed: () {
                  Navigator.of(context).pushNamed(AddVideoScreen.routeName);
                },
              ),
              AdminButton(
                label: 'Add Materials',
                icon: IconlyLight.paper_download,
                onPressed: () {
                  Navigator.of(context).pushNamed(AddMaterialsScreen.routeName);
                },
              ),
              AdminButton(
                label: 'Add Exam',
                icon: IconlyLight.document,
                onPressed: () {
                  Navigator.of(context).pushNamed(AddExamScreen.routeName);
                },
              ),
            ],
          ],
        );
      },
    );
  }
}

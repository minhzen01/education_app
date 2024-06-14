import 'package:education_app/core/common/app/providers/user_provider.dart';
import 'package:education_app/core/res/app_colors.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/src/profile/presentation/views/widgets/user_info_card.dart';
import 'package:flutter/material.dart';
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
          ],
        );
      },
    );
  }
}

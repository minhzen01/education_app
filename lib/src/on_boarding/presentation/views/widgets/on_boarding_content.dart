import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/res/app_colors.dart';
import 'package:education_app/core/res/app_const.dart';
import 'package:education_app/core/res/fonts.dart';
import 'package:education_app/src/on_boarding/domain/entities/on_boarding_entity.dart';
import 'package:education_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({
    required this.entity,
    super.key,
  });

  final OnBoardingEntity entity;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          entity.image,
          height: context.height * .4,
        ),
        SizedBox(height: context.height * .03),
        Padding(
          padding: const EdgeInsets.all(20).copyWith(bottom: 0),
          child: Column(
            children: [
              Text(
                entity.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: Fonts.aeonik,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: context.height * .02),
              Text(
                entity.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: Fonts.aeonik,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: context.height * .05),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 50),
                  backgroundColor: AppColors.primaryColour,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  context.read<OnBoardingCubit>().cacheFirstTimer();
                },
                child: const Text(
                  AppConst.getStarted,
                  style: TextStyle(fontFamily: Fonts.aeonik, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

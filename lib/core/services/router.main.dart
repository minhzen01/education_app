part of 'router.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      final prefs = sl<SharedPreferences>();
      return _pageBuilder(
        (context) {
          if (prefs.getBool(OnBoardingConstants.kFirstTimerKey) ?? true) {
            return BlocProvider(
              create: (_) => sl<OnBoardingCubit>(),
              child: const OnboardingScreen(),
            );
          } else if (sl<FirebaseAuth>().currentUser != null) {
            final user = sl<FirebaseAuth>().currentUser!;
            final localUser = UserEntityModel(
              uid: user.uid,
              email: user.email ?? '',
              points: 0,
              fullName: user.displayName ?? '',
            );
            context.userProvider.initUser(
              UserEntity(
                uid: localUser.uid,
                email: localUser.email,
                points: localUser.points,
                fullName: localUser.fullName,
              ),
            );
            return const DashboardScreen();
          }
          return BlocProvider(
            create: (_) => sl<AuthBloc>(),
            child: const SignInScreen(),
          );
        },
        settings: settings,
      );
    case SignInScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const SignInScreen(),
        ),
        settings: settings,
      );
    case SignUpScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: const SignUpScreen(),
        ),
        settings: settings,
      );
    case DashboardScreen.routeName:
      return _pageBuilder(
        (_) => const DashboardScreen(),
        settings: settings,
      );

    case '/forgot-password':
      return _pageBuilder(
        (_) => const fui.ForgotPasswordScreen(),
        settings: settings,
      );
    case CourseDetailsScreen.routeName:
      return _pageBuilder(
        (_) => CourseDetailsScreen(course: settings.arguments! as Course),
        settings: settings,
      );
    case ExamDetailsScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (context) => sl<ExamCubit>(),
          child: ExamDetailsScreen(exam: settings.arguments! as ExamEntity),
        ),
        settings: settings,
      );

    case ExamHistoryDetailsScreen.routeName:
      return _pageBuilder(
        (_) => ExamHistoryDetailsScreen(exam: settings.arguments! as UserExamEntity),
        settings: settings,
      );

    case ExamScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (context) => sl<ExamCubit>(),
          child: ChangeNotifierProvider(
            create: (context) => ExamController(exam: settings.arguments! as ExamEntity),
            child: const ExamScreen(),
          ),
        ),
        settings: settings,
      );

    case AddVideoScreen.routeName:
      return _pageBuilder(
        (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<CourseCubit>()),
            BlocProvider(create: (_) => sl<VideoCubit>()),
            BlocProvider(create: (_) => sl<NotificationCubit>()),
          ],
          child: const AddVideoScreen(),
        ),
        settings: settings,
      );
    case AddMaterialsScreen.routeName:
      return _pageBuilder(
        (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<CourseCubit>()),
            BlocProvider(create: (_) => sl<MaterialCubit>()),
            BlocProvider(create: (_) => sl<NotificationCubit>()),
          ],
          child: const AddMaterialsScreen(),
        ),
        settings: settings,
      );
    case AddExamScreen.routeName:
      return _pageBuilder(
        (_) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<CourseCubit>()),
            BlocProvider(create: (_) => sl<ExamCubit>()),
            BlocProvider(create: (_) => sl<NotificationCubit>()),
          ],
          child: const AddExamScreen(),
        ),
        settings: settings,
      );
    case CourseVideosScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<VideoCubit>(),
          child: CourseVideosScreen(course: settings.arguments! as Course),
        ),
        settings: settings,
      );

    case VideoPlayerScreen.routeName:
      return _pageBuilder(
        (_) => VideoPlayerScreen(videoURL: settings.arguments! as String),
        settings: settings,
      );
    case CourseMaterialsScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<MaterialCubit>(),
          child: CourseMaterialsScreen(course: settings.arguments! as Course),
        ),
        settings: settings,
      );
    case CourseExamsScreen.routeName:
      return _pageBuilder(
        (_) => BlocProvider(
          create: (_) => sl<ExamCubit>(),
          child: CourseExamsScreen(course: settings.arguments! as Course),
        ),
        settings: settings,
      );
    default:
      return _pageBuilder(
        (_) => const PageUnderConstruction(),
        settings: settings,
      );
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
    pageBuilder: (context, _, __) => page(context),
  );
}

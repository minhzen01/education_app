part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> initial() async {
  await _initOnBoarding();
  await _initAuth();
  await _initCourse();
  await _initVideo();
  await _initMaterial();
  await _initExam();
}

Future<void> _initOnBoarding() async {
  final prefs = await SharedPreferences.getInstance();

  sl
    ..registerFactory(() => OnBoardingCubit(sl(), sl()))
    ..registerLazySingleton(() => CacheFirstTimerUseCase(sl()))
    ..registerLazySingleton(() => CheckIfUserIsFirstTimerUseCase(sl()))
    ..registerLazySingleton<OnBoardingRepository>(() => OnBoardingRepositoryImpl(sl()))
    ..registerLazySingleton<OnBoardingLocalDataSource>(() => OnBoardingLocalDataSourceImpl(sl()))
    ..registerLazySingleton(() => prefs);
}

Future<void> _initAuth() async {
  sl
    ..registerFactory(() => AuthBloc(sl(), sl(), sl(), sl()))
    ..registerLazySingleton(() => SignInUseCase(sl()))
    ..registerLazySingleton(() => SignUpUseCase(sl()))
    ..registerLazySingleton(() => ForgotPasswordUseCase(sl()))
    ..registerLazySingleton(() => UpdateUserUseCase(sl()))
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()))
    ..registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(sl(), sl(), sl()))
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance);
}

Future<void> _initCourse() async {
  sl
    ..registerFactory(() => CourseCubit(sl(), sl()))
    ..registerLazySingleton(() => AddCourseUseCase(sl()))
    ..registerLazySingleton(() => GetCoursesUseCase(sl()))
    ..registerLazySingleton<CourseRepository>(() => CourseRepositoryImpl(sl()))
    ..registerLazySingleton<CourseRemoteDataSource>(() => CourseRemoteDataSourceImpl(sl(), sl(), sl()));
}

Future<void> _initVideo() async {
  sl
    ..registerFactory(() => VideoCubit(sl(), sl()))
    ..registerLazySingleton(() => AddVideoUseCase(sl()))
    ..registerLazySingleton(() => GetVideosUseCase(sl()))
    ..registerLazySingleton<VideoRepository>(() => VideoRepositoryImpl(sl()))
    ..registerLazySingleton<VideoRemoteDataSource>(() => VideoRemoteDataSourceImpl(sl(), sl(), sl()));
}

Future<void> _initMaterial() async {
  sl
    ..registerFactory(() => MaterialCubit(sl(), sl()))
    ..registerLazySingleton(() => AddMaterialUseCase(sl()))
    ..registerLazySingleton(() => GetMaterialsUseCase(sl()))
    ..registerLazySingleton<MaterialRepository>(() => MaterialRepositoryImpl(sl()))
    ..registerLazySingleton<MaterialRemoteDataSource>(() => MaterialRemoteDataSourceImpl(sl(), sl(), sl()));
}

Future<void> _initExam() async {
  sl
    ..registerFactory(() => ExamCubit(sl(), sl(), sl(), sl(), sl(), sl(), sl()))
    ..registerLazySingleton(() => GetExamQuestionsUseCase(sl()))
    ..registerLazySingleton(() => GetExamsUseCase(sl()))
    ..registerLazySingleton(() => SubmitExamUseCase(sl()))
    ..registerLazySingleton(() => UpdateExamUseCase(sl()))
    ..registerLazySingleton(() => UploadExamUseCase(sl()))
    ..registerLazySingleton(() => GetUserCourseExamsUseCase(sl()))
    ..registerLazySingleton(() => GetUserExamsUseCase(sl()))
    ..registerLazySingleton<ExamRepository>(() => ExamRepositoryImpl(sl()))
    ..registerLazySingleton<ExamRemoteDataSource>(() => ExamRemoteDataSourceImpl(sl(), sl()));
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/src/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:education_app/src/authentication/data/datasources/auth_remote_data_source_impl.dart';
import 'package:education_app/src/authentication/data/repositories/auth_repository_impl.dart';
import 'package:education_app/src/authentication/domain/repositories/auth_repository.dart';
import 'package:education_app/src/authentication/domain/usecases/forgot_password_use_case.dart';
import 'package:education_app/src/authentication/domain/usecases/sign_in_use_case.dart';
import 'package:education_app/src/authentication/domain/usecases/sign_up_use_case.dart';
import 'package:education_app/src/authentication/domain/usecases/update_user_use_case.dart';
import 'package:education_app/src/authentication/presentation/bloc/auth_bloc.dart';
import 'package:education_app/src/course/data/datasources/course_remote_data_source.dart';
import 'package:education_app/src/course/data/datasources/course_remote_data_source_impl.dart';
import 'package:education_app/src/course/data/repositories/course_repository_impl.dart';
import 'package:education_app/src/course/domain/repositories/course_repository.dart';
import 'package:education_app/src/course/domain/usecases/add_course_use_case.dart';
import 'package:education_app/src/course/domain/usecases/get_courses_use_case.dart';
import 'package:education_app/src/course/features/exams/data/datasources/exam_remote_data_source.dart';
import 'package:education_app/src/course/features/exams/data/datasources/exam_remote_data_source_impl.dart';
import 'package:education_app/src/course/features/exams/data/repositories/exam_repository_impl.dart';
import 'package:education_app/src/course/features/exams/domain/repositories/exam_repository.dart';
import 'package:education_app/src/course/features/exams/domain/usecases/get_exam_questions_use_case.dart';
import 'package:education_app/src/course/features/exams/domain/usecases/get_exams_use_case.dart';
import 'package:education_app/src/course/features/exams/domain/usecases/get_user_course_exams_use_case.dart';
import 'package:education_app/src/course/features/exams/domain/usecases/get_user_exams_use_case.dart';
import 'package:education_app/src/course/features/exams/domain/usecases/submit_exam_use_case.dart';
import 'package:education_app/src/course/features/exams/domain/usecases/update_exam_use_case.dart';
import 'package:education_app/src/course/features/exams/domain/usecases/upload_exam_use_case.dart';
import 'package:education_app/src/course/features/exams/presentation/cubit/exam_cubit.dart';
import 'package:education_app/src/course/features/materials/data/datasources/material_remote_data_source.dart';
import 'package:education_app/src/course/features/materials/data/datasources/material_remote_data_source_impl.dart';
import 'package:education_app/src/course/features/materials/data/repositories/material_repository_impl.dart';
import 'package:education_app/src/course/features/materials/domain/repositories/material_repository.dart';
import 'package:education_app/src/course/features/materials/domain/usecases/add_material_use_case.dart';
import 'package:education_app/src/course/features/materials/domain/usecases/get_materials_use_case.dart';
import 'package:education_app/src/course/features/materials/presentation/cubit/material_cubit.dart';
import 'package:education_app/src/course/features/videos/data/datasources/video_remote_data_source.dart';
import 'package:education_app/src/course/features/videos/data/datasources/video_remote_data_source_impl.dart';
import 'package:education_app/src/course/features/videos/data/repositories/video_repository_impl.dart';
import 'package:education_app/src/course/features/videos/domain/repositories/video_repository.dart';
import 'package:education_app/src/course/features/videos/domain/usecases/add_video_use_case.dart';
import 'package:education_app/src/course/features/videos/domain/usecases/get_videos_use_case.dart';
import 'package:education_app/src/course/features/videos/presentation/cubit/video_cubit.dart';
import 'package:education_app/src/course/presentation/cubit/course_cubit.dart';
import 'package:education_app/src/notifications/data/datasources/notification_remote_data_source.dart';
import 'package:education_app/src/notifications/data/datasources/notification_remote_data_source_impl.dart';
import 'package:education_app/src/notifications/data/repositories/notification_repository_impl.dart';
import 'package:education_app/src/notifications/domain/repositories/notification_repository.dart';
import 'package:education_app/src/notifications/domain/usecases/clear_all_use_case.dart';
import 'package:education_app/src/notifications/domain/usecases/clear_use_case.dart';
import 'package:education_app/src/notifications/domain/usecases/get_notifications_use_case.dart';
import 'package:education_app/src/notifications/domain/usecases/mark_as_read_use_case.dart';
import 'package:education_app/src/notifications/domain/usecases/send_notification_use_case.dart';
import 'package:education_app/src/notifications/presentation/cubit/notification_cubit.dart';
import 'package:education_app/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:education_app/src/on_boarding/data/datasources/on_boarding_local_data_source_impl.dart';
import 'package:education_app/src/on_boarding/data/repositories/on_boarding_repository_impl.dart';
import 'package:education_app/src/on_boarding/domain/repositories/on_boarding_repository.dart';
import 'package:education_app/src/on_boarding/domain/usecases/cache_first_timer_use_case.dart';
import 'package:education_app/src/on_boarding/domain/usecases/check_if_user_is_first_timer_use_case.dart';
import 'package:education_app/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'injection_container.main.dart';

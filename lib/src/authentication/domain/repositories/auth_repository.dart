import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/authentication/domain/entities/user_entity.dart';
import 'package:education_app/src/authentication/domain/entities/update_user_enum.dart';

abstract class AuthRepository {
  const AuthRepository();

  ResultFuture<void> forgotPassword({required String email});

  ResultFuture<UserEntity> signIn({
    required String email,
    required String password,
  });

  ResultFuture<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    dynamic userData,
  });
}

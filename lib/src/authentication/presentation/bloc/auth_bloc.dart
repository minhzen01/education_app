import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:education_app/src/authentication/domain/entities/sign_in_params.dart';
import 'package:education_app/src/authentication/domain/entities/sign_up_params.dart';
import 'package:education_app/src/authentication/domain/entities/update_user_enum.dart';
import 'package:education_app/src/authentication/domain/entities/update_user_params.dart';
import 'package:education_app/src/authentication/domain/entities/user_entity.dart';
import 'package:education_app/src/authentication/domain/usecases/forgot_password_use_case.dart';
import 'package:education_app/src/authentication/domain/usecases/sign_in_use_case.dart';
import 'package:education_app/src/authentication/domain/usecases/sign_up_use_case.dart';
import 'package:education_app/src/authentication/domain/usecases/update_user_use_case.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  AuthBloc(
    this._signInUseCase,
    this._signUpUseCase,
    this._forgotPasswordUseCase,
    this._updateUserUseCase,
  ) : super(const AuthInitialState()) {
    on<AuthEvent>(_authEvent);
    on<SignInEvent>(_signInEvent);
    on<SignUpEvent>(_signUpEvent);
    on<ForgotPasswordEvent>(_forgotPasswordEvent);
    on<UpdateUserEvent>(_updateUserEvent);
  }
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final UpdateUserUseCase _updateUserUseCase;

  FutureOr<void> _authEvent(AuthEvent event, Emitter<AuthState> emit) async {
    emit(const AuthLoadingState());
  }

  FutureOr<void> _signInEvent(SignInEvent event, Emitter<AuthState> emit) async {
    final result = await _signInUseCase.call(
      SignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.errorMessage)),
      (success) => emit(SignedInState(user: success)),
    );
  }

  FutureOr<void> _signUpEvent(SignUpEvent event, Emitter<AuthState> emit) async {
    final result = await _signUpUseCase.call(
      SignUpParams(
        email: event.email,
        fullName: event.fullName,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.errorMessage)),
      (_) => emit(const SignedUpState()),
    );
  }

  FutureOr<void> _forgotPasswordEvent(ForgotPasswordEvent event, Emitter<AuthState> emit) async {
    final result = await _forgotPasswordUseCase.call(event.email);

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.errorMessage)),
      (_) => emit(const ForgotPasswordSentState()),
    );
  }

  FutureOr<void> _updateUserEvent(UpdateUserEvent event, Emitter<AuthState> emit) async {
    final result = await _updateUserUseCase.call(
      UpdateUserParams(
        action: event.action,
        userData: event.userData,
      ),
    );

    result.fold(
      (failure) => emit(AuthErrorState(message: failure.errorMessage)),
      (_) => emit(const UserUpdatedState()),
    );
  }
}

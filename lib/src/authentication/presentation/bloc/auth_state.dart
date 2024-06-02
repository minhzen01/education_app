part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {
  const AuthInitialState();
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState();
}

class SignedInState extends AuthState {
  const SignedInState({
    required this.user,
  });

  final UserEntity user;

  @override
  List<Object> get props => [user];
}

class SignedUpState extends AuthState {
  const SignedUpState();
}

class ForgotPasswordSentState extends AuthState {
  const ForgotPasswordSentState();
}

class UserUpdatedState extends AuthState {
  const UserUpdatedState();
}

class AuthErrorState extends AuthState {
  const AuthErrorState({
    required this.message,
  });

  final String message;

  @override
  List<String> get props => [message];
}

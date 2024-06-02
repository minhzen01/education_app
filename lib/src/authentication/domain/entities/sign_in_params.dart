import 'package:equatable/equatable.dart';

class SignInParams extends Equatable {
  const SignInParams({
    required this.email,
    required this.password,
  });

  factory SignInParams.empty() {
    return const SignInParams(
      email: '',
      password: '',
    );
  }

  final String email;
  final String password;

  @override
  List<String> get props => [email, password];
}

import 'package:equatable/equatable.dart';

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.email,
    required this.fullName,
    required this.password,
  });

  factory SignUpParams.empty() {
    return const SignUpParams(
      email: '',
      fullName: '',
      password: '',
    );
  }

  final String email;
  final String fullName;
  final String password;

  @override
  List<String> get props => [email, fullName, password];
}

import 'package:education_app/src/authentication/domain/entities/update_user_enum.dart';
import 'package:equatable/equatable.dart';

class UpdateUserParams extends Equatable {
  const UpdateUserParams({
    required this.action,
    required this.userData,
  });

  factory UpdateUserParams.empty() {
    return const UpdateUserParams(
      action: UpdateUserAction.displayName,
      userData: '',
    );
  }

  final UpdateUserAction action;
  final dynamic userData;

  @override
  List<dynamic> get props => [action, userData];
}

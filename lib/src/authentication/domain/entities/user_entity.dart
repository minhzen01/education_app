import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.uid,
    required this.email,
    required this.points,
    required this.fullName,
    this.groupIds = const [],
    this.enrolledCourseIds = const [],
    this.following = const [],
    this.followers = const [],
    this.profilePic,
    this.bio,
  });

  factory UserEntity.empty() {
    return const UserEntity(
      uid: '',
      email: '',
      points: 0,
      fullName: '',
      profilePic: '',
      bio: '',
    );
  }

  final String uid;
  final String email;
  final String? profilePic;
  final String? bio;
  final int points;
  final String fullName;
  final List<String> groupIds;
  final List<String> enrolledCourseIds;
  final List<String> following;
  final List<String> followers;

  @override
  String toString() {
    return 'AuthUserEntity{uid: $uid, email: $email, bio: $bio, points: $points, fullName: $fullName}';
  }

  bool get isAdmin => email == 'minhzen@gmail.com';

  @override
  List<Object?> get props => [
        uid,
        email,
        profilePic,
        bio,
        points,
        fullName,
        groupIds.length,
        enrolledCourseIds.length,
        following.length,
        followers.length,
      ];
}

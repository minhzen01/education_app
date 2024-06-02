import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.uid,
    required this.email,
    required this.points,
    required this.fullName,
    required this.groupId,
    required this.enrolledCourseIds,
    required this.following,
    required this.follower,
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
      groupId: [],
      enrolledCourseIds: [],
      following: [],
      follower: [],
    );
  }

  final String uid;
  final String email;
  final String? profilePic;
  final String? bio;
  final int points;
  final String fullName;
  final List<String> groupId;
  final List<String> enrolledCourseIds;
  final List<String> following;
  final List<String> follower;

  @override
  String toString() {
    return 'AuthUserEntity{uid: $uid, email: $email, bio: $bio, points: $points, fullName: $fullName}';
  }

  @override
  List<Object?> get props => [uid, email];
}

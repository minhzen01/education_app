import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/authentication/domain/entities/user_entity.dart';

class UserEntityModel extends UserEntity {
  const UserEntityModel({
    required super.uid,
    required super.email,
    required super.points,
    required super.fullName,
    super.groupIds,
    super.enrolledCourseIds,
    super.following,
    super.followers,
    super.profilePic,
    super.bio,
  });

  factory UserEntityModel.empty() {
    return const UserEntityModel(
      uid: '',
      email: '',
      points: 0,
      fullName: '',
    );
  }

  factory UserEntityModel.fromMap(DataMap map) {
    return UserEntityModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      points: map['points'] as int,
      fullName: map['fullName'] as String,
      profilePic: map['profilePic'] as String,
      bio: map['bio'] as String,
      groupIds: (map['groupIds'] as List<dynamic>).cast<String>(),
      enrolledCourseIds: (map['enrolledCourseIds'] as List<dynamic>).cast<String>(),
      following: (map['following'] as List<dynamic>).cast<String>(),
      followers: (map['followers'] as List<dynamic>).cast<String>(),
    );
  }

  DataMap toMap() {
    return {
      'uid': uid,
      'email': email,
      'profilePic': profilePic,
      'bio': bio,
      'points': points,
      'fullName': fullName,
      'groupIds': groupIds,
      'enrolledCourseIds': enrolledCourseIds,
      'following': following,
      'followers': followers,
    };
  }

  UserEntityModel copyWith({
    String? uid,
    String? email,
    String? profilePic,
    String? bio,
    int? points,
    String? fullName,
    List<String>? groupIds,
    List<String>? enrolledCourseIds,
    List<String>? following,
    List<String>? followers,
  }) {
    return UserEntityModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
      bio: bio ?? this.bio,
      points: points ?? this.points,
      fullName: fullName ?? this.fullName,
      groupIds: groupIds ?? this.groupIds,
      enrolledCourseIds: enrolledCourseIds ?? this.enrolledCourseIds,
      following: following ?? this.following,
      followers: followers ?? this.followers,
    );
  }
}

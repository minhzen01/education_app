import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/services/injection_container.dart';
import 'package:education_app/src/authentication/data/models/user_model.dart';
import 'package:education_app/src/authentication/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardUtils {
  const DashboardUtils._();

  static Stream<UserEntity> get userDataStream =>
      sl<FirebaseFirestore>().collection('users').doc(sl<FirebaseAuth>().currentUser!.uid).snapshots().map(
        (event) {
          final data = UserEntityModel.fromMap(event.data()!);
          return UserEntity(
            uid: data.uid,
            email: data.email,
            points: data.points,
            fullName: data.fullName,
          );
        },
      );
}

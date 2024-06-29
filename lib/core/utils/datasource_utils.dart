import 'package:education_app/core/errors/exceptions/server_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatasourceUtils {
  const DatasourceUtils._();

  static Future<void> authorizeUser(FirebaseAuth auth) async {
    final user = auth.currentUser;
    if (user == null) {
      throw const ServerException(
        statusCode: '401',
        message: 'User is not authenticated',
      );
    }
  }
}

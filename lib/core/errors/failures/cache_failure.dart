import 'package:education_app/core/errors/failures/failure.dart';

class CacheFailure extends Failure {
  CacheFailure({
    required super.statusCode,
    required super.message,
  });
}

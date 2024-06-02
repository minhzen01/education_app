import 'package:education_app/core/errors/exceptions/server_exception.dart';
import 'package:education_app/core/errors/failures/failure.dart';

class ServerFailure extends Failure {
  ServerFailure({
    required super.statusCode,
    required super.message,
  });

  factory ServerFailure.fromException(ServerException exception) {
    return ServerFailure(
      statusCode: exception.statusCode,
      message: exception.message,
    );
  }
}

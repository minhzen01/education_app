import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure({
    required this.statusCode,
    required this.message,
  }) : assert(
          statusCode is int || statusCode is String,
          "StatusCode can't be a ${statusCode.runtimeType}",
        );

  final dynamic statusCode;
  final String message;

  String get errorMessage => 'Error: $statusCode - $message';

  @override
  List<dynamic> get props => [statusCode, message];
}

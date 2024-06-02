import 'package:education_app/core/utils/typedefs.dart';

abstract class UseCaseWithoutParams<Type> {
  const UseCaseWithoutParams();

  ResultFuture<Type> call();
}

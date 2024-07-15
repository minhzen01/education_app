import 'package:education_app/core/utils/typedefs.dart';

abstract class StreamUseCaseWithoutParams<Type> {
  const StreamUseCaseWithoutParams();

  ResultStream<Type> call();
}

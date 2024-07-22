import 'package:education_app/core/utils/typedefs.dart';

abstract class StreamUseCaseWithParams<Type, Params> {
  const StreamUseCaseWithParams();

  ResultStream<Type> call(Params params);
}

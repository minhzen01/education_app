import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/materials/domain/entities/resource_entity.dart';

abstract class MaterialRepository {
  const MaterialRepository();

  ResultFuture<List<ResourceEntity>> getMaterials(String courseId);

  ResultFuture<void> addMaterial(ResourceEntity material);
}

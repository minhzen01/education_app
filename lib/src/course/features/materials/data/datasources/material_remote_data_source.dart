import 'package:education_app/src/course/features/materials/data/models/resource_model.dart';
import 'package:education_app/src/course/features/materials/domain/entities/resource_entity.dart';

abstract class MaterialRemoteDataSource {
  const MaterialRemoteDataSource();

  Future<List<ResourceModel>> getMaterials(String courseId);

  Future<void> addMaterial(ResourceEntity material);
}

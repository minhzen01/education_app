import 'package:education_app/core/usecases/use_case_with_params.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/materials/domain/entities/resource_entity.dart';
import 'package:education_app/src/course/features/materials/domain/repositories/material_repository.dart';

class AddMaterialUseCase extends UseCaseWithParams<void, ResourceEntity> {
  const AddMaterialUseCase(this._repository);

  final MaterialRepository _repository;

  @override
  ResultFuture<void> call(ResourceEntity params) async {
    return _repository.addMaterial(params);
  }
}

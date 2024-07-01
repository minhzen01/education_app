import 'package:education_app/core/usecases/use_case_with_params.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/course/features/materials/domain/entities/resource_entity.dart';
import 'package:education_app/src/course/features/materials/domain/repositories/material_repository.dart';

class GetMaterialsUseCase extends UseCaseWithParams<List<ResourceEntity>, String> {
  const GetMaterialsUseCase(this._repository);

  final MaterialRepository _repository;

  @override
  ResultFuture<List<ResourceEntity>> call(String params) async {
    return _repository.getMaterials(params);
  }
}

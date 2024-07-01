import 'package:bloc/bloc.dart';
import 'package:education_app/src/course/features/materials/domain/entities/resource_entity.dart';
import 'package:education_app/src/course/features/materials/domain/usecases/add_material_use_case.dart';
import 'package:education_app/src/course/features/materials/domain/usecases/get_materials_use_case.dart';
import 'package:equatable/equatable.dart';

part 'material_state.dart';

class MaterialCubit extends Cubit<MaterialState> {
  MaterialCubit(
    this._addMaterialUseCase,
    this._getMaterialsUseCase,
  ) : super(const MaterialInitialState());

  final AddMaterialUseCase _addMaterialUseCase;
  final GetMaterialsUseCase _getMaterialsUseCase;

  Future<void> addMaterial(List<ResourceEntity> materials) async {
    emit(const AddingMaterialState());
    for (final material in materials) {
      final result = await _addMaterialUseCase.call(material);
      result.fold(
        (failure) {
          emit(MaterialErrorState(message: failure.message));
          return;
        },
        (_) => null,
      );
    }
    if (state is! MaterialErrorState) emit(const MaterialAddedState());
  }

  Future<void> getMaterials(String courseId) async {
    emit(const LoadingMaterialsState());
    final result = await _getMaterialsUseCase.call(courseId);
    result.fold(
      (failure) => emit(MaterialErrorState(message: failure.message)),
      (success) => emit(MaterialsLoadedState(materials: success)),
    );
  }
}

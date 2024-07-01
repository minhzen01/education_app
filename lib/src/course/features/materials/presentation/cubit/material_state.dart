part of 'material_cubit.dart';

sealed class MaterialState extends Equatable {
  const MaterialState();

  @override
  List<Object?> get props => [];
}

class MaterialInitialState extends MaterialState {
  const MaterialInitialState();
}

class AddingMaterialState extends MaterialState {
  const AddingMaterialState();
}

class MaterialAddedState extends MaterialState {
  const MaterialAddedState();
}

class LoadingMaterialsState extends MaterialState {
  const LoadingMaterialsState();
}

class MaterialsLoadedState extends MaterialState {
  const MaterialsLoadedState({required this.materials});

  final List<ResourceEntity> materials;

  @override
  List<Object?> get props => [materials];
}

class MaterialErrorState extends MaterialState {
  const MaterialErrorState({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

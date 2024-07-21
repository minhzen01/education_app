import 'package:education_app/core/common/views/loading_view.dart';
import 'package:education_app/core/common/widgets/gradient_background.dart';
import 'package:education_app/core/common/widgets/nested_back_button.dart';
import 'package:education_app/core/common/widgets/not_found_text.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/core/services/injection_container.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/src/course/domain/entities/course.dart';
import 'package:education_app/src/course/features/materials/presentation/cubit/material_cubit.dart';
import 'package:education_app/src/course/features/materials/presentation/providers/resource_controller.dart';
import 'package:education_app/src/course/features/materials/presentation/widgets/resource_tile.dart';
import 'package:flutter/material.dart' hide MaterialState;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class CourseMaterialsScreen extends StatefulWidget {
  const CourseMaterialsScreen({
    required this.course,
    super.key,
  });

  static const routeName = '/course-materials';

  final Course course;

  @override
  State<CourseMaterialsScreen> createState() => _CourseMaterialsScreenState();
}

class _CourseMaterialsScreenState extends State<CourseMaterialsScreen> {
  void getMaterials() {
    context.read<MaterialCubit>().getMaterials(widget.course.id);
  }

  @override
  void initState() {
    super.initState();
    getMaterials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('${widget.course.title} Materials'),
        leading: const NestedBackButton(),
      ),
      body: GradientBackground(
        image: MediaRes.documentsGradientBackground,
        child: BlocConsumer<MaterialCubit, MaterialState>(
          listener: (context, state) {
            if (state is MaterialErrorState) {
              CoreUtils.showSnackBar(context, state.message);
            } else if (state is LoadingMaterialsState) {}
          },
          builder: (context, state) {
            if (state is LoadingMaterialsState) {
              return const LoadingView();
            } else if ((state is MaterialsLoadedState && state.materials.isEmpty) || state is MaterialErrorState) {
              return NotFoundText(text: 'No videos found for ${widget.course.title}');
            } else if (state is MaterialsLoadedState) {
              final materials = state.materials..sort((a, b) => b.uploadTime.compareTo(a.uploadTime));
              return SafeArea(
                child: ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemBuilder: (context, index) {
                    return ChangeNotifierProvider(
                      create: (_) => sl<ResourceController>()..init(materials[index]),
                      child: const ResourceTile(),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(color: Color(0xFFE6E8EC));
                  },
                  itemCount: materials.length,
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

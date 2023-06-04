import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_list/src/cubit/projects_cubit.dart';

class ProjectTypeButton extends StatelessWidget {
  const ProjectTypeButton({
    super.key,
    required this.onTap,
    required this.projectTypeId,
  });
  final VoidCallback onTap;
  final int projectTypeId;

  @override
  Widget build(BuildContext context) {
    var types = context.read<ProjectsCubit>().state.projectTypes;
    var name = types.firstWhere((t) => t.id == projectTypeId).name;
    return GestureDetector(onTap: onTap, child: Text(name));
  }
}

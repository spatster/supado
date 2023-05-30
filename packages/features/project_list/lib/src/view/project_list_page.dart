import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_list/src/cubit/projects_cubit.dart';
import 'package:project_list/src/view/project_list_view.dart';
import 'package:projects_repository/projects_repository.dart';

class ProjectListPage extends StatelessWidget {
  const ProjectListPage({super.key});
  static const route = '/';

  @override
  Widget build(BuildContext context) {
    var repository = context.read<ProjectsRepository>();

    return BlocProvider(
      create: (_) => ProjectsCubit(repository)..loadProjects(),
      child: ProjectListView(),
    );
  }
}

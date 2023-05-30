import 'package:projects_repository/projects_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:supado_api/supado_api.dart';

part 'projects_state.dart';

class ProjectsCubit extends Cubit<ProjectsState> {
  ProjectsCubit(this.repository) : super(ProjectsState(projects: []));

  final ProjectsRepository repository;

  loadProjects() async {
    var res = await repository.getProjects();
    res.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    emit(state.copyWith(projects: res));
  }

  createProject(Project project) async {
    await repository.createProject(project);
    await loadProjects();
  }
}

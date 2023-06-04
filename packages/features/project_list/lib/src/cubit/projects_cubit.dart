import 'package:projects_repository/projects_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:supado_api/supado_api.dart';

part 'projects_state.dart';

class ProjectsCubit extends Cubit<ProjectsState> {
  ProjectsCubit(ProjectsRepository repository)
      : _repository = repository,
        super(ProjectsState(projects: []));

  final ProjectsRepository _repository;

  loadProjects() async {
    var res = await _repository.getProjects();
    res.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    emit(state.copyWith(projects: res));
  }

  loadProjectTypes() async {
    var res = await _repository.getProjectTypes();
    emit(state.copyWith(projectTypes: res));
  }

  createProject(Project project) async {
    await _repository.createProject(project);
    await loadProjects();
  }

  createSubtask(Subtask subtask) async {
    await _repository.createSubtask(subtask);
    await loadProjects();
  }

  deleteProject(int id) async {
    await _repository.deleteProject(id);
    var projects = state.projects.where((p) => p.id != id).toList();
    emit(state.copyWith(projects: projects));
  }

  changeSubtaskState(Subtask subtask) async {
    try {
      var s = subtask.copyWith();
      s.changeStatus();
      await _repository.updateSubtask(s);
      //Fix
      await loadProjects();
    } catch (e) {
      //TODO: add handler
    }
  }
}

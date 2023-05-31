import 'package:collection/collection.dart';
import 'package:supado_api/supado_api.dart';

class ProjectsRepository {
  final SupadoApi api;

  ProjectsRepository({required this.api});

  Future<List<Project>> getProjects() async {
    return await api.getProjects();
  }

  Future createProject(Project project) async {
    await api.createProject(project);
  }

  Future createSubtask(Subtask subtack) async {
    await api.createSubtask(subtack);
  }

  Future deleteProject(int id) async {
    await api.deleteProject(id);
  }

  Future updateSubtask(Subtask task) async {
    await api.updateSubtask(task);
  }

  Future updateProjectsOrder(List<Project> actions) async {
    List<Map<String, dynamic>> actionsIds = [];
    actions.forEachIndexed((index, a) {
      actionsIds.add({'id': a.id, 'index_number': index});
    });
    //await api.upsertProjects(actionsIds);
  }
}

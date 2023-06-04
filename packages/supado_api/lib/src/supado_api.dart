import 'package:supado_api/src/models/project_type.dart';
import 'package:supado_api/supado_api.dart';

abstract class SupadoApi {
  Future<List<Project>> getProjects();
  Future createProject(Project project);
  Future deleteProject(int id);
  Future upsertProjects(List<Project> projects);
  Future createSubtask(Subtask task);
  Future updateSubtask(Subtask task);
  Future<List<ProjectType>> getProjectTypes();
}

import 'package:supado_api/supado_api.dart';

abstract class SupadoApi {
  Future<List<Project>> getProjects();
  Future createProject(Project project);
  Future upsertProjects(List<Project> projects);
}

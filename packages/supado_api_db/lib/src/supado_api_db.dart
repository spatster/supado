import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supado_api/supado_api.dart';

/// {@template supabase_database_exception}
/// A generic supabase database exception.
/// {@endtemplate}
abstract class SupabaseDatabaseException implements Exception {
  /// {@macro supabase_database_exception}
  const SupabaseDatabaseException(this.error);

  /// The error which was caught.
  final Object error;
}

/// {@template supabase_user_information_failure}
/// Thrown during the get user information process if a failure occurs.
/// {@endtemplate}
class SupabaseUserInformationFailure extends SupabaseDatabaseException {
  /// {@macro supabase_user_information_failure}
  const SupabaseUserInformationFailure(super.error);
}

/// {@template supabase_update_user_failure}
/// Thrown during the update user information process if a failure occurs.
/// {@endtemplate}
class SupabaseUpdateUserFailure extends SupabaseDatabaseException {
  /// {@macro supabase_update_user_failure}
  const SupabaseUpdateUserFailure(super.error);
}

/// {@template supabase_database_client}
/// Supabase database client
/// {@endtemplate}
class SupadoApiDb implements SupadoApi {
  /// {@macro supabase_database_client}
  const SupadoApiDb({
    required SupabaseClient supabaseClient,
  }) : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  @override
  Future<List<Project>> getProjects() async {
    try {
      List<Map<String, dynamic>> res = await _supabaseClient
          .from('projects')
          .select('*, project_subtasks(*), project_statuses(*)');
      return res.map((a) => Project.fromJson(a)).toList();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        SupabaseUserInformationFailure(error),
        stackTrace,
      );
    }
  }

  @override
  Future createProject(Project project) async {
    try {
      await _supabaseClient.from('projects').insert(project.toJson());
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        SupabaseUserInformationFailure(error),
        stackTrace,
      );
    }
  }

  @override
  Future createSubtask(Subtask task) async {
    try {
      await _supabaseClient.from('project_subtasks').insert(task.toJson());
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        SupabaseUserInformationFailure(error),
        stackTrace,
      );
    }
  }

  @override
  Future<List<ProjectType>> getProjectTypes() async {
    try {
      List<Map<String, dynamic>> res =
          await _supabaseClient.from('project_types').select();
      return res.map((a) => ProjectType.fromJson(a)).toList();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        SupabaseUserInformationFailure(error),
        stackTrace,
      );
    }
  }

  @override
  Future updateSubtask(Subtask task) async {
    var x = task.toJson();
    try {
      await _supabaseClient
          .from('project_subtasks')
          .update(task.toJson())
          .eq('id', task.id);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        SupabaseUserInformationFailure(error),
        stackTrace,
      );
    }
  }

  @override
  Future deleteProject(int id) async {
    await _supabaseClient.from('projects').delete().eq('id', id);
  }

  @override
  Future upsertProjects(List<Project> projects) async {
    /*try {
      for (var p in projects) {
        await _supabaseClient
            .from('projects')
            .update({'index_number': p['index_number']}).eq('id', p['id']);
      }
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        SupabaseUserInformationFailure(error),
        stackTrace,
      );
    }*/
  }
}

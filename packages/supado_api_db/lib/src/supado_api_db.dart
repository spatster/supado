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
      List<Map<String, dynamic>> res =
          await _supabaseClient.from('projects').select();
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

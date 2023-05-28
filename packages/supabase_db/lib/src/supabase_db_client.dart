import 'package:supabase_api/supabase_api.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
class SupabaseDbClient implements SupabaseApi {
  /// {@macro supabase_database_client}
  const SupabaseDbClient({
    required SupabaseClient supabaseClient,
  }) : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  @override
  Future<List<Map<String, dynamic>>> getActions() async {
    try {
      return await _supabaseClient.from('actions').select();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        SupabaseUserInformationFailure(error),
        stackTrace,
      );
    }
  }

  @override
  Future createAction(Map<String, dynamic> action) async {
    try {
      await _supabaseClient.from('actions').insert(action);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        SupabaseUserInformationFailure(error),
        stackTrace,
      );
    }
  }

  @override
  Future upsertActions(List<Map<String, dynamic>> actions) async {
    try {
      for (var action in actions) {
        await _supabaseClient.from('actions').update(
            {'index_number': action['index_number']}).eq('id', action['id']);
      }
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        SupabaseUserInformationFailure(error),
        stackTrace,
      );
    }
  }
}

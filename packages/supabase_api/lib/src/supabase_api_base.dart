abstract class SupabaseApi {
  Future<List<Map<String, dynamic>>> getActions();
  Future createAction();
}

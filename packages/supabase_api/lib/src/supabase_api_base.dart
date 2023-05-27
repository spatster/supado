abstract class SupabaseApi {
  Future<List<Map<dynamic, dynamic>>> getActions();
  Future createAction();
}

abstract class SupabaseApi {
  Future<List<Map<String, dynamic>>> getActions();
  Future createAction(Map<String, dynamic> action);
  Future upsertActions(List<Map<String, dynamic>> actions);
}

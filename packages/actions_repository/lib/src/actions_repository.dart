import 'package:domain_models/domain_models.dart';
import 'package:supabase_api/supabase_api.dart';
import 'package:collection/collection.dart';

class ActionsRepository {
  final SupabaseApi api;

  ActionsRepository({required this.api});

  Future<List<ActionX>> getActions() async {
    var res = await api.getActions();
    return res.map((a) => ActionX.fromJson(a)).toList();
  }

  Future createAction(ActionX action) async {
    await api.createAction(action.toJson());
  }

  Future updateActionsOrder(List<ActionX> actions) async {
    List<Map<String, dynamic>> actionsIds = [];
    actions.forEachIndexed((index, a) {
      actionsIds.add({'id': a.id, 'index_number': index});
    });
    await api.upsertActions(actionsIds);
  }
}

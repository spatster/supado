import 'package:domain_models/domain_models.dart';
import 'package:supabase_api/supabase_api.dart';

class ActionsRepository {
  final SupabaseApi api;

  ActionsRepository({required this.api});

  Future<List<ActionX>> getActions() async {
    var res = await api.getActions();
    return res.map((a) => ActionX.fromJson(a)).toList();
  }
}

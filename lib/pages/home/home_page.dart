import 'package:actions_repository/actions_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class HomePage extends StatefulWidget {
  static const route = '/';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<ActionX> actions = [];
  ActionX? selectedAction;

  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    var repository = context.read<ActionsRepository>();
    var a = await repository.getActions();
    setState(() {
      a.sort((a, b) => a.indexNumber.compareTo(b.indexNumber));
      actions = a;
    });
  }

  logout() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    await supabase.auth.signOut();
                  },
                  child: Text('Logout')),
              Expanded(
                child: ReorderableListView.builder(
                  itemCount: actions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      key: Key('$index'),
                      children: [
                        ListTile(
                          title: Text(actions[index].name),
                          onTap: () {
                            setState(() {
                              selectedAction = actions[index];
                            });
                          },
                        ),
                        const Divider(),
                      ],
                    );
                  },
                  onReorder: (oldIndex, newIndex) async {
                    if (newIndex > oldIndex) newIndex--;
                    var newList = List<ActionX>.from(actions);
                    final item = newList.removeAt(oldIndex);
                    newList.insert(newIndex, item);
                    var repository = context.read<ActionsRepository>();
                    await repository.updateActionsOrder(newList);
                    await load();
                  },
                ),
              ),
            ],
          ),
          if (selectedAction != null)
            DraggableScrollableSheet(
              minChildSize: 0.1,
              maxChildSize: 0.8,
              initialChildSize: 0.1,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Row(
                        children: [
                          const Spacer(),
                          Container(
                            height: 4,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.grey,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Container(
                          color: Colors.blue[100],
                          child: Text(selectedAction!.name)),
                    ],
                  ),
                );
              },
            )
        ],
      ),
    );
  }
}

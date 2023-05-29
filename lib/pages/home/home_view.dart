import 'package:actions_repository/actions_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supafluttodo/pages/home/cubit/actions_cubit.dart';

final supabase = Supabase.instance.client;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ActionX? selectedAction;

  void _onEdit(ActionX action) {
    var cubit = context.read<ActionsCubit>();
    cubit.createAction(action);
  }

  void _showSheet() async {
    var res = await showModalBottomSheet(
      context: context,
      isScrollControlled: true, // set this to true
      builder: (_) {
        return EditAction(selectedAction: selectedAction, onEdit: _onEdit);
      },
    );
    setState(() {
      selectedAction = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    var actions = context.watch<ActionsCubit>().state.actions;

    return Scaffold(
      appBar: AppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showSheet();
        },
        tooltip: 'Increment',
        elevation: 2.0,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.blueGrey,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[],
        ),
      ),
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
                            _showSheet();
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
                    //await load();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EditAction extends StatefulWidget {
  EditAction({super.key, this.selectedAction, required this.onEdit});

  final ActionX? selectedAction;
  final Function onEdit;

  @override
  State<EditAction> createState() => _EditActionState();
}

class _EditActionState extends State<EditAction> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nameInputController;
  late final TextEditingController descriptionInputController;

  @override
  void initState() {
    nameInputController =
        TextEditingController(text: widget.selectedAction?.name ?? '');
    descriptionInputController =
        TextEditingController(text: widget.selectedAction?.description ?? '');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      minChildSize: 0.5,
      maxChildSize: 0.9,
      initialChildSize: 0.5,
      expand: false,
      builder: (_, controller) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 20),
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
              const SizedBox(height: 10),
              Expanded(
                child: ListView(
                  controller: controller,
                  children: [
                    const SizedBox(height: 5),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: nameInputController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Action name',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: descriptionInputController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: const InputDecoration.collapsed(
                                hintText: 'Description'),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    var newAction = ActionX(
                                        name: nameInputController.text,
                                        description:
                                            descriptionInputController.text);

                                    widget.onEdit(newAction);
                                  }
                                },
                                child: Icon(Icons.send),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

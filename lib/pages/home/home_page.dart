import 'package:actions_repository/actions_repository.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static const route = '/';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<ActionX> actions = [];

  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    var repository = context.read<ActionsRepository>();
    var a = await repository.getActions();
    setState(() {
      actions = a;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: actions.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(actions[index].name),
          );
        },
      ),
    );
  }
}

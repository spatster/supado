import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_list/src/components/create_project.dart';
import 'package:project_list/src/components/project_tile.dart';
import 'package:project_list/src/cubit/projects_cubit.dart';
import 'package:flutter/material.dart';
import 'package:projects_repository/projects_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supado_api/supado_api.dart';

final supabase = Supabase.instance.client;

class ProjectListView extends StatefulWidget {
  const ProjectListView({super.key});

  @override
  State<ProjectListView> createState() => _ProjectListViewState();
}

class _ProjectListViewState extends State<ProjectListView> {
  Project? selectedProject;

  void _showSheet() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true, // set this to true
      builder: (_) {
        return BlocProvider.value(
          value: BlocProvider.of<ProjectsCubit>(context),
          child: CreateProject(),
        );
      },
    );
    setState(() {
      selectedProject = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    var projects = context.watch<ProjectsCubit>().state.projects;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () async {
                await supabase.auth.signOut();
              },
              child: Icon(
                Icons.exit_to_app,
                size: 26.0,
              ),
            ),
          )
        ],
      ),
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
              Expanded(
                child: ReorderableListView.builder(
                  itemCount: projects.length,
                  itemBuilder: (BuildContext context, int index) {
                    var project = projects[index];
                    return ProjectTileSlidable(
                      key: Key('$index'),
                      onDelete: () async {
                        context
                            .read<ProjectsCubit>()
                            .deleteProject(project.id!);
                      },
                      child: ProjectTile(
                        project: project,
                        onTap: () {
                          setState(() {
                            selectedProject = project;
                          });
                          _showSheet();
                        },
                      ),
                    );
                  },
                  onReorder: (oldIndex, newIndex) async {
                    if (newIndex > oldIndex) newIndex--;
                    var newList = List<Project>.from(projects);
                    final item = newList.removeAt(oldIndex);
                    newList.insert(newIndex, item);
                    var repository = context.read<ProjectsRepository>();
                    await repository.updateProjectsOrder(newList);
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

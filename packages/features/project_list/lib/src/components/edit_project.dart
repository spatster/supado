import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_list/src/components/bottomsheet_decoration.dart';
import 'package:project_list/src/components/project_form.dart';
import 'package:project_list/src/components/subtask_form.dart';
import 'package:project_list/src/components/subtasks_list.dart';
import 'package:project_list/src/cubit/projects_cubit.dart';
import 'package:supado_api/supado_api.dart';

class EditProject extends StatefulWidget {
  EditProject({super.key, required this.projectId});

  int projectId;

  @override
  State<EditProject> createState() => _EditProjectState();
}

class _EditProjectState extends State<EditProject> {
  bool createTaskMode = false;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProjectsCubit, ProjectsState, Project>(
      selector: (state) {
        return state.projects.firstWhere((p) => p.id == widget.projectId);
      },
      builder: (context, project) {
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
                  BottomsheetDecoration(),
                  Expanded(
                    child: ListView(
                      controller: controller,
                      children: [
                        Text(project.name),
                        Divider(),
                        SizedBox(height: 10),
                        if (!createTaskMode)
                          GestureDetector(
                            child: Text('+ Add subtask'),
                            onTap: () {
                              setState(() {
                                createTaskMode = true;
                              });
                            },
                          ),
                        if (createTaskMode)
                          SubtaskForm(
                            selectedProject: project,
                            onClose: () {
                              setState(() {
                                createTaskMode = false;
                              });
                            },
                          ),
                        if (!createTaskMode)
                          SubtasksList(project: project, showFinished: true),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

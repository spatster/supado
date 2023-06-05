import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_list/src/components/bottomsheet_decoration.dart';
import 'package:project_list/src/components/project_form.dart';
import 'package:project_list/src/components/subtask_form.dart';
import 'package:project_list/src/components/subtasks_list.dart';
import 'package:project_list/src/cubit/projects_cubit.dart';
import 'package:supado_api/supado_api.dart';

class EditTask extends StatefulWidget {
  EditTask({super.key, required this.subtask, required this.selectedProject});

  Subtask subtask;
  Project selectedProject;

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
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
              BottomsheetDecoration(),
              Expanded(
                child: ListView(
                  controller: controller,
                  children: [
                    SubtaskForm(
                      selectedProject: widget.selectedProject,
                      subtask: widget.subtask,
                    )
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

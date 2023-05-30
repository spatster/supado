import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_list/src/components/bottomsheet_decoration.dart';
import 'package:project_list/src/components/project_form.dart';
import 'package:project_list/src/cubit/projects_cubit.dart';
import 'package:supado_api/supado_api.dart';

class EditProject extends StatefulWidget {
  EditProject({super.key});

  @override
  State<EditProject> createState() => _EditProjectState();
}

class _EditProjectState extends State<EditProject> {
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
                    const SizedBox(height: 5),
                    ProjectForm(selectedProject: null),
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

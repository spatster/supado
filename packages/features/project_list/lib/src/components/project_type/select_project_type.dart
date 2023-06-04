import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_list/src/components/bottomsheet_decoration.dart';
import 'package:project_list/src/cubit/projects_cubit.dart';
import 'package:supado_api/supado_api.dart';

class SelectProjectType extends StatelessWidget {
  const SelectProjectType({super.key, required this.selectedTypeId});
  final int selectedTypeId;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProjectsCubit, ProjectsState, List<ProjectType>>(
      selector: (state) {
        return state.projectTypes;
      },
      builder: (context, projectTypes) {
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
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        var type = projectTypes[index];
                        return GestureDetector(
                          child: Text(
                            type.name,
                            style: TextStyle(
                                fontSize: 24,
                                color: selectedTypeId == type.id
                                    ? Colors.blue
                                    : null),
                          ),
                          onTap: () {
                            Navigator.pop(context, type.id);
                          },
                        );
                      },
                      itemCount: projectTypes.length,
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}

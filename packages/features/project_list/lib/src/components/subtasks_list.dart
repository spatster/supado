import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_list/src/components/project_tile.dart';
import 'package:project_list/src/cubit/projects_cubit.dart';
import 'package:supado_api/supado_api.dart';

class SubtasksList extends StatelessWidget {
  const SubtasksList({super.key, required this.project, this.showFinished});

  final Project project;
  final bool? showFinished;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ReorderableListView.builder(
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var subtask = showFinished == true
              ? project.sortedSubtasks[index]
              : project.unfinishedSubtasks[index];
          return Row(
            key: Key('subtask$index'),
            children: [
              IconButton(
                  onPressed: () {
                    var projectCubit = context.read<ProjectsCubit>();
                    projectCubit.changeSubtaskState(subtask);
                  },
                  icon: Icon(subtask.finishedAt == null
                      ? Icons.radio_button_unchecked
                      : Icons.task_alt)),
              Text(subtask.name)
            ],
          );
        },
        itemCount: showFinished == true
            ? project.sortedSubtasks.length
            : project.unfinishedSubtasks.length,
        onReorder: (oldIndex, newIndex) {},
      ),
    );
  }
}

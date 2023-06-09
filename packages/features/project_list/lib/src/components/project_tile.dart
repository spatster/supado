import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:project_list/src/components/subtasks_list.dart';
import 'package:project_list/src/cubit/projects_cubit.dart';
import 'package:supado_api/supado_api.dart';

class ProjectTile extends StatefulWidget {
  const ProjectTile({super.key, required this.project, required this.onTap});
  final Project project;
  final VoidCallback onTap;

  @override
  State<ProjectTile> createState() => _ProjectTileState();
}

class _ProjectTileState extends State<ProjectTile>
    with TickerProviderStateMixin {
  bool expandSubtask = false;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  void _toggleContainer() {
    expandSubtask = !expandSubtask;
    if (expandSubtask) {
      _controller.forward();
    } else {
      _controller.animateBack(0, duration: Duration(milliseconds: 500));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.project.name),
                      if (widget.project.subtasks.length != 0)
                        Row(
                          children: [
                            Icon(Icons.subdirectory_arrow_right),
                            Text(
                              '${widget.project.finishedSubtasksCount} / ${widget.project.subtasksCount}',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        )
                    ],
                  ),
                  if (widget.project.subtasksCount != 0)
                    IconButton(
                      icon: Icon(expandSubtask
                          ? Icons.expand_less
                          : Icons.expand_more),
                      onPressed: () {
                        _toggleContainer();
                      },
                    )
                ],
              ),
              SizeTransition(
                sizeFactor: _animation,
                child: SubtasksList(project: widget.project),
              )
            ],
          ),
          onTap: widget.onTap,
        ),
        const Divider(),
      ],
    );
  }
}

class ProjectTileSlidable extends StatelessWidget {
  ProjectTileSlidable({super.key, required this.child, required this.onDelete});
  final Widget child;
  final Function onDelete;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: const ValueKey(0),

      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        children: [
          SlidableAction(
            onPressed: (context) {
              onDelete();
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),

      child: child,
    );
  }
}

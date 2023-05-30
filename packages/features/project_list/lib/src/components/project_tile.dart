import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:supado_api/supado_api.dart';

class ProjectTile extends StatelessWidget {
  const ProjectTile({super.key, required this.project, required this.onTap});
  final Project project;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(project.name),
          onTap: onTap,
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

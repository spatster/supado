import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_list/src/cubit/projects_cubit.dart';
import 'package:supado_api/supado_api.dart';

class SubtaskForm extends StatefulWidget {
  const SubtaskForm({super.key, required this.selectedProject});
  final Project? selectedProject;

  @override
  State<SubtaskForm> createState() => _SubtaskFormState();
}

class _SubtaskFormState extends State<SubtaskForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nameInputController;

  late final TextEditingController descriptionInputController;

  _resetForm() {
    nameInputController.text = '';
    descriptionInputController.text = '';
  }

  @override
  void initState() {
    nameInputController = TextEditingController(text: '');
    descriptionInputController = TextEditingController(text: '');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            decoration: const InputDecoration.collapsed(
              hintText: 'Subtask name',
              hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: descriptionInputController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration:
                const InputDecoration.collapsed(hintText: 'Description'),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var newSubtask = Subtask(
                        name: nameInputController.text,
                        projectId: widget.selectedProject!.id!);

                    var cubit = context.read<ProjectsCubit>();
                    cubit.createSubtask(newSubtask);
                    _resetForm();
                  }
                },
                child: Icon(Icons.send),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

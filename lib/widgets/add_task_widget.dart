import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasklist/models/task.dart';
import 'package:tasklist/providers/task_providers.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({Key? key}) : super(key: key);

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController taskNameController = TextEditingController();
  final container = ProviderContainer();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar Tarea'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: taskNameController,
            decoration: const InputDecoration(labelText: 'Nombre de la tarea'),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Agregar'),
          onPressed: () {
            if (taskNameController.text.isNotEmpty) {
              final newTask = Task(
                id: DateTime.now().toString(),
                name: taskNameController.text,
                isCompleted: false,
              );

              container.read(firestoreServiceProvider).addTask(newTask);

              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}

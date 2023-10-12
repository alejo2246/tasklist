import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasklist/models/task.dart';
import 'package:tasklist/providers/task_providers.dart';
import 'package:tasklist/widgets/add_task_widget.dart';

class TaskListPage extends ConsumerWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tareas'),
        backgroundColor: const Color.fromARGB(255, 202, 250, 248),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(10),
              child: _buildFilterTags(ref, context)),
          Expanded(
            child: tasks.when(
              data: (data) => data.isNotEmpty
                  ? ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final task = data[index];
                        return GestureDetector(
                          onTap: () {
                            ref.read(firestoreServiceProvider).updateTask(
                                  task.copyWith(isCompleted: !task.isCompleted),
                                );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: ListTile(
                                title: Text(
                                  task.name,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    decoration: task.isCompleted
                                        ? TextDecoration.lineThrough
                                        : null,
                                    color: task.isCompleted
                                        ? Colors.grey
                                        : Colors.black87,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Color.fromARGB(255, 243, 143, 136),
                                  ),
                                  onPressed: () =>
                                      _deleteTask(ref, task.id, context),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        "Crea una tarea nueva...",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
              error: (error, _) => const Center(
                  child: Text(
                "Ha ocurrido un error.",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              )),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildFilterTags(WidgetRef ref, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildFilterTag(ref, 'Todas', null, 0, context),
        _buildFilterTag(ref, 'Completas', true, 1, context),
        _buildFilterTag(ref, 'Incompletas', false, 2, context),
      ],
    );
  }

  Widget _buildFilterTag(WidgetRef ref, String label, bool? completed,
      int selectedFilter, BuildContext context) {
    final selected = ref.watch(selectedFilterProvider);
    return ElevatedButton(
      onPressed: () {
        ref.read(filterProvider.notifier).state = completed;
        ref.read(selectedFilterProvider.notifier).state = selectedFilter;
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            selectedFilter == selected ? Theme.of(context).primaryColor : null,
        foregroundColor: selectedFilter == selected ? Colors.white : null,
      ),
      child: Text(label),
    );
  }

  Future<void> _showAddTaskDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddTaskDialog();
      },
    );
  }

  void _deleteTask(WidgetRef ref, String taskId, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmar eliminación"),
          content:
              const Text("¿Estás seguro de que deseas eliminar esta tarea?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();

                ref.read(firestoreServiceProvider).deleteTask(taskId);
              },
              child: const Text("Eliminar"),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasklist/models/task.dart';
import 'package:tasklist/services/firestore_service.dart';

final firestoreServiceProvider = StateProvider<FirestoreService>((ref) {
  return FirestoreService();
});

final tasksProvider = StreamProvider<List<Task>>((ref) {
  final container = ProviderContainer();
  final firestoreService = container.read(firestoreServiceProvider);
  final isCompleted = ref.watch(filterProvider);
  final tasks = firestoreService.getTasks(isCompleted: isCompleted);
  return tasks;
});

final filterProvider = StateProvider<bool?>((ref) => null);

final selectedFilterProvider = StateProvider<int>((ref) => 0);

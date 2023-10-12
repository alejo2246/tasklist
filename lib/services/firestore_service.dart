import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasklist/models/task.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Task>> getTasks({bool? isCompleted}) {
    Query query =
        _firestore.collection('tasks').orderBy('timestamp', descending: false);

    if (isCompleted != null) {
      query = query.where('isCompleted', isEqualTo: isCompleted);
    }

    return query.snapshots().map((querySnapshot) => querySnapshot.docs
        .map((doc) => Task(
              id: doc.id,
              name: doc['name'],
              isCompleted: doc['isCompleted'],
            ))
        .toList());
  }

  Future<void> addTask(Task task) async {
    await _firestore.collection('tasks').add({
      'name': task.name,
      'isCompleted': task.isCompleted,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateTask(Task task) async {
    await _firestore.collection('tasks').doc(task.id).update({
      'name': task.name,
      'isCompleted': task.isCompleted,
    });
  }

  Future<void> deleteTask(String taskId) async {
    await _firestore.collection('tasks').doc(taskId).delete();
  }
}

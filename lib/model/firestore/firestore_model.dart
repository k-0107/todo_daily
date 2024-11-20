import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreModel {
  final db = FirebaseFirestore.instance;

  Future<void> createTask(int index, String task) async {
    await db.collection('task').doc('$index').set({
      'task': task,
      'createdAt': FieldValue.serverTimestamp(),
      'isCompleted': false,
    });
  }

  // Future<void> readTask() async {}
  Future<void> updateTask(int index, String updatedTask) async {
    await db.collection('task').doc('$index').update({
      'task': updatedTask,
    });
  }
  // Future<void> delete() async {}
}

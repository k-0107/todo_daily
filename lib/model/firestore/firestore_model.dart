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

  Future<void> updateTask(int index, String updatedTask) async {
    await db.collection('task').doc('$index').update({
      'task': updatedTask,
    });
  }

  Future<void> deleteTask(int index) async {
    await db.collection('task').doc('$index').delete();
  }

  Stream<List<Map<String, dynamic>>> fetchTasks() {
    return db.collection('task').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data(),
        };
      }).toList();
    });
  }
}

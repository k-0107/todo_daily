import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreModel {
  final db = FirebaseFirestore.instance;

  Future<void> createTask(String task) async {
    await db.collection('task').doc().set({
      'task': task,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateTask(String taskID, String updatedTask) async {
    await db.collection('task').doc(taskID.toString()).update({
      'task': updatedTask,
    });
  }

  Future<void> deleteTask(String taskID) async {
    await db.collection('task').doc(taskID.toString()).delete();
  }

  Stream<List<Map<String, dynamic>>> fetchTasks() {
    return db.collection('task').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'ID': doc.id, // ID を取得
          'task': doc['task'], // task を取得
        };
      }).toList();
    });
  }
}

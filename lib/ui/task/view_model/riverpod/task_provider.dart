import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_daily/model/firestore/firestore_model.dart';
part 'task_provider.g.dart';

// Firestore からタスクを取得するストリームプロバイダ
@riverpod
Stream<List<Map<String, dynamic>>> taskStream(ref) {
  final firestore = FirestoreModel();
  return firestore.fetchTasks();
}

// TodoList クラス（ローカルでタスクを管理するプロバイダ）
@riverpod
class TodoList extends _$TodoList {
  final firestore = FirestoreModel();

  @override
  Stream<List<Map<String, dynamic>>> build() {
    return firestore.fetchTasks();
  }

  // データを変更する関数
  Future<void> addTask(String task) async {
    // Firestoreにタスクを保存
    await firestore.createTask(task);
  }

  // タスクを編集する関数
  Future<void> editTask(String index, String editask) async {
    await firestore.updateTask(index, editask);
  }

  Future<void> deleteTask(String index) async {
    await firestore.deleteTask(index);
  }

  // void reorderTask(int oldIndex, int newIndex) {
  //   final updatedList = [...state];
  //   final task = updatedList.removeAt(oldIndex);
  //   updatedList.insert(newIndex, task);
  //   state = updatedList;
  // }
}

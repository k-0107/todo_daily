import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_daily/model/firestore/firestore_model.dart';
part 'task_provider.g.dart';

@riverpod
class TodoList extends _$TodoList {
  final firestore = FirestoreModel();

  @override
  List<String> build() {
    return [];
  }

  // データを変更する関数
  Future<void> addTask(int index, String task) async {
    // Firestoreにタスクを保存
    try {
      await firestore.createTask(index, task);
      // 変更前のデータ
      final oldState = state;
      // 変更後のデータ
      final newState = [...oldState, task];
      // 上書き
      state = newState;
    } catch (e) {
      debugPrint('Error while adding task: $e');
      rethrow; // 必要に応じてエラーを再スロー
    }
  }

  // タスクを編集する関数
  Future<void> editTask(int index, String editask) async {
    await firestore.updateTask(index, editask);
    // 編集前のデータ
    final oldState = state;
    // 指定したインデックスのタスクを新しい内容に変更
    final updatedState = List<String>.from(oldState); // コピーを作成して更新
    updatedState[index] = editask;
    // 上書き
    state = updatedState;
  }

  void deleteTask(int index) {
    // 変更前のデータ
    final oldState = state;

    // 新しいリストを作成し、指定されたインデックスの要素を削除
    final updatedState = [...oldState];
    updatedState.removeAt(index);

    //final updatedState = [...oldState]..removeAt(index); 上2行はこれでもOK(カスケード演算子)

    // 更新されたリストで state を上書き
    state = updatedState;
  }

  void reorderTask(int oldIndex, int newIndex) {
    final updatedList = [...state];
    final task = updatedList.removeAt(oldIndex);
    updatedList.insert(newIndex, task);
    state = updatedList;
  }
}

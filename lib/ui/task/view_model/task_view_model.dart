import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'task_view_model.g.dart';

@riverpod
class TodoList extends _$TodoList {
  @override
  List<String> build() {
    return [];
  }

  // データを変更する関数
  void addTask(String task) {
    // 変更前のデータ
    final oldState = state;
    debugPrint('$oldState');
    // 変更後のデータ
    final newState = [...oldState, task];
    debugPrint('$newState');
    // 上書き
    state = newState;
  }

  // タスクを編集する関数
  void editTask(int index, String newTask) {
    // 編集前のデータ
    final oldState = state;
    // 指定したインデックスのタスクを新しい内容に変更
    final updatedState = [...oldState];
    updatedState[index] = newTask;
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

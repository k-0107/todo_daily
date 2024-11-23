import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_daily/ui/task/view_model/riverpod/task_provider.dart';

class TaskListViewModel {
  TaskListViewModel(this.ref);
  final WidgetRef ref;

  // void reorderTask(BuildContext context, int oldIndex, int newIndex) {
  //   if (newIndex > oldIndex) newIndex -= 1;
  //   final notifier = ref.read(todoListProvider.notifier);
  //   notifier.reorderTask(oldIndex, newIndex);
  // }

  void gotoEditPage(BuildContext context, String index) {
    context.go('/t_edit', extra: index);
  }

  void goAddPage(BuildContext context) {
    context.push('/t_add');
  }

  void deleteTask(BuildContext context, String index) {
    final notifier = ref.read(todoListProvider.notifier);
    notifier.deleteTask(index);
  }
}

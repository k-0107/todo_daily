import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_daily/ui/task/view_model/riverpod/task_provider.dart';

class TaskAddViewModel {
  TaskAddViewModel(this.controller, this.ref);

  final TextEditingController controller;
  final WidgetRef ref;

  void addTask(BuildContext context) {
    final taskList = ref.watch(todoListProvider);

    if (controller.text.isNotEmpty) {
      final notifier = ref.read(todoListProvider.notifier);
      notifier.addTask(
        taskList.length,
        controller.text,
      );
      controller.clear();
      context.push('/');
    }
  }

  void goBack(BuildContext context) {
    context.pop('/');
  }
}

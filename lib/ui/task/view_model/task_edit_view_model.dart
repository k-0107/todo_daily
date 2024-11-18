import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_daily/ui/task/view_model/riverpod/task_provider.dart';

class TaskEditViewModel {
  TaskEditViewModel(this.ref, this.controller);
  final WidgetRef ref;
  final TextEditingController controller;

  void doEdit(BuildContext context, int taskIndex) {
    if (controller.text.isNotEmpty) {
      final notifier = ref.read(todoListProvider.notifier);
      notifier.editTask(taskIndex, controller.text);
      controller.clear();
      context.push('/');
    }
  }

  void goBack(BuildContext context) {
    context.go('/');
  }
}

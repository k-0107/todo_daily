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

    taskList.when(
      data: (taskList) {
        if (controller.text.isNotEmpty) {
          final notifier = ref.read(todoListProvider.notifier);
          notifier.addTask(
            controller.text,
          );
          controller.clear();
          context.push('/');
        }
      },
      loading: () {},
      error: (error, stackTrace) {
        debugPrint('Error adding task: $error');
      },
    );
  }

  void goBack(BuildContext context) {
    context.pop('/');
  }
}

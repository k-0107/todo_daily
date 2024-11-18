import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_daily/ui/task/view_model/riverpod/task_provider.dart';
import 'package:todo_daily/ui/task/view_model/task_edit_view_model.dart';

class TaskEditPage extends ConsumerWidget {
  final int taskIndex;
  const TaskEditPage({super.key, required this.taskIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskList = ref.watch(todoListProvider);
    final controller = TextEditingController(text: taskList[taskIndex]);

    final viewModel = TaskEditViewModel(ref, controller);

    return Scaffold(
      appBar: AppBar(
        title: const Text('タスク編集'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'タスク編集  (男に二言はないぞ!!)',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                viewModel.doEdit(context, taskIndex);
              },
              child: const Icon(Icons.add),
            ),
            ElevatedButton(
              onPressed: () {
                viewModel.goBack(context);
              },
              child: const Icon(Icons.post_add),
            ),
          ],
        ),
      ),
    );
  }
}

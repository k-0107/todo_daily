import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_daily/ui/task/view_model/task_add_view_model.dart';

class TaskAddPage extends ConsumerWidget {
  TaskAddPage({super.key});
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = TaskAddViewModel(controller, ref);
    return Scaffold(
      appBar: AppBar(
        title: const Text('タスク追加'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '追加タスク入力  (絶対やれよな!!)',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                viewModel.addTask(context);
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

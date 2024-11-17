import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_daily/ui/task/view_model/task_view_model.dart';

class TaskAddPage extends ConsumerWidget {
  TaskAddPage({super.key});
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                if (controller.text.isNotEmpty) {
                  final notifier = ref.read(todoListProvider.notifier);
                  notifier.addTask(controller.text);
                  controller.clear();
                  context.push('/a');
                }
              },
              child: const Icon(Icons.add),
            ),
            ElevatedButton(
              onPressed: () {
                context.pop('/a');
              },
              child: const Icon(Icons.post_add),
            ),
          ],
        ),
      ),
    );
  }
}

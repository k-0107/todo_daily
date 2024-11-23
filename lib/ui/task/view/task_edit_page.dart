import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_daily/ui/task/view_model/riverpod/task_provider.dart';
import 'package:todo_daily/ui/task/view_model/task_edit_view_model.dart';

class TaskEditPage extends ConsumerWidget {
  final String taskID;
  const TaskEditPage({super.key, required this.taskID});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskListAsync =
        ref.watch(todoListProvider); // taskStreamProviderからデータを取得

    final taskList = ref.watch(todoListProvider).value ?? [];

    final task = taskList.firstWhere(
      (element) => element['ID'] == taskID,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('タスク編集'),
      ),
      body: taskListAsync.when(
        data: (taskList) {
          // taskListが空でないか確認
          if (taskList.isEmpty) {
            return const Center(child: Text('タスクが見つかりません'));
          }

          final controller = TextEditingController(text: task['task'] ?? '');
          final viewModel = TaskEditViewModel(ref, controller);

          return Center(
            child: Column(
              children: [
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'タスク編集',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    viewModel.doEdit(context, taskID);
                  },
                  child: const Icon(Icons.save),
                ),
                ElevatedButton(
                  onPressed: () {
                    viewModel.goBack(context);
                  },
                  child: const Icon(Icons.cancel),
                ),
              ],
            ),
          );
        },
        loading: () =>
            const Center(child: CircularProgressIndicator()), // ローディング中
        error: (error, stackTrace) =>
            Center(child: Text('エラーが発生しました: $error')), // エラー時
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_daily/ui/task/view_model/riverpod/task_provider.dart';
import 'package:todo_daily/ui/task/view_model/task_edit_view_model.dart';

class TaskEditPage extends ConsumerWidget {
  final int taskIndex;
  const TaskEditPage({super.key, required this.taskIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskListAsync =
        ref.watch(taskStreamProvider); // taskStreamProviderからデータを取得

    return Scaffold(
      appBar: AppBar(
        title: Text('タスク編集'),
      ),
      body: taskListAsync.when(
        data: (taskList) {
          // taskListが空でないか確認
          if (taskIndex >= taskList.length) {
            return const Center(child: Text('タスクが見つかりません'));
          }

          final controller =
              TextEditingController(text: taskList[taskIndex]['task']);
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
                    viewModel.doEdit(context, taskIndex);
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

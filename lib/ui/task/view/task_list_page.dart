import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_daily/ui/task/view_model/riverpod/task_provider.dart';
import 'package:todo_daily/ui/task/view_model/task_list_view_model.dart';

class TaskListPage extends ConsumerWidget {
  const TaskListPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskStream = ref.watch(todoListProvider);
    final viewModel = TaskListViewModel(ref);

    return Scaffold(
      appBar: AppBar(
        title: const Text('タスク追加'),
      ),
      body: taskStream.when(
        data: (tasks) {
          if (tasks.isEmpty) {
            return Column(
              children: [
                const Center(
                  child: Text('タスクがありません'),
                ),
                SizedBox(
                  height: 100,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: () {
                        viewModel.goAddPage(context);
                      },
                      child: const Icon(Icons.add),
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (c, i) {
                      final task = tasks[i];
                      return Card(
                        key: ValueKey(task),
                        child: ListTile(
                          title: Text(task['task']),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  debugPrint(task['ID']);
                                  viewModel.gotoEditPage(context, task['ID']);
                                },
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  viewModel.deleteTask(context, task['ID']);
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: () {
                        viewModel.goAddPage(context);
                      },
                      child: const Icon(Icons.add),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 150,
                )
              ],
            ),
          );
        },
        loading: () =>
            const Center(child: CircularProgressIndicator()), // ローディング中の表示
        error: (err, stack) => Center(
          child: Text('エラーが発生しました: $err'),
        ),
      ),
    );
  }
}

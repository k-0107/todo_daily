import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_daily/ui/task/view_model/riverpod/task_provider.dart';
import 'package:todo_daily/ui/task/view_model/task_list_view_model.dart';

class TaskListPage extends ConsumerWidget {
  const TaskListPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoListProvider);
    final viewModel = TaskListViewModel(ref);

    return Scaffold(
      appBar: AppBar(
        title: const Text('タスク追加'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ReorderableListView.builder(
                itemCount: todoList.length,
                onReorder: (oldIndex, newIndex) {
                  viewModel.reorderTask(context, oldIndex, newIndex);
                },
                itemBuilder: (c, i) {
                  return Card(
                    key: ValueKey(todoList[i]),
                    child: ListTile(
                      title: Text(todoList[i]),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              viewModel.gotoEditPage(context, i);
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              viewModel.deleteTask(context, i);
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_daily/ui/task/view_model/task_view_model.dart';

class TaskListPage extends ConsumerWidget {
  const TaskListPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoListProvider);

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
                  // リストを並べ替える処理
                  if (newIndex > oldIndex) newIndex -= 1;
                  final notifier = ref.read(todoListProvider.notifier);
                  notifier.reorderTask(oldIndex, newIndex);
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
                              context.go('/c', extra: i);
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              final notifier =
                                  ref.read(todoListProvider.notifier);
                              notifier.deleteTask(i);
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
                    context.push('/b');
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

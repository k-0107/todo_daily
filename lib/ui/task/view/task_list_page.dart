import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
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
        title: Text(
          'To DO Daily',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(120, 241, 238, 215),
      ),
      backgroundColor: const Color.fromARGB(120, 253, 250, 224),
      body: taskStream.when(
        data: (tasks) {
          if (tasks.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      '今日のタスクはありません。',
                      style:
                          GoogleFonts.kaiseiDecol(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: SizedBox(
                      height: 100,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: FloatingActionButton(
                          onPressed: () {
                            viewModel.goAddPage(context);
                          },
                          child: const Icon(Icons.add),
                          backgroundColor:
                              const Color.fromARGB(170, 97, 111, 70),
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (c, i) {
                        final task = tasks[i];
                        return Card(
                          color: const Color.fromARGB(255, 213, 177, 113),
                          key: ValueKey(task),
                          child: ListTile(
                            title: Text(
                              task['task'],
                              style: GoogleFonts.kaiseiDecol(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  color: const Color.fromARGB(255, 8, 9, 11),
                                  onPressed: () {
                                    debugPrint(task['ID']);
                                    viewModel.gotoEditPage(context, task['ID']);
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  color: const Color.fromARGB(255, 197, 72, 66),
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
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: SizedBox(
                      height: 100,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: FloatingActionButton(
                          onPressed: () {
                            viewModel.goAddPage(context);
                          },
                          child: const Icon(Icons.add),
                          backgroundColor:
                              const Color.fromARGB(170, 97, 111, 70),
                          foregroundColor: Colors.white,
                        ),
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

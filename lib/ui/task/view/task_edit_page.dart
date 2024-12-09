import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
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
        title: Text(
          'Edit Task',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 249, 248, 241),
      ),
      backgroundColor: const Color.fromARGB(255, 186, 187, 178),
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
                Image.asset(
                  'assets/images/todo-edit.jpg',
                  width: 500,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: 400,
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'タスク編集 ~ 男に二言は無い ~',
                        labelStyle: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            onPressed: () {
                              viewModel.goBack(context);
                            },
                            child: const Text(
                              '← タスク一覧に戻る',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 79, 73, 72)),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          color: const Color.fromARGB(255, 25, 116, 23),
                          onPressed: () {
                            viewModel.doEdit(context, taskID);
                          },
                          icon: const Icon(
                            Icons.save,
                            size: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
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

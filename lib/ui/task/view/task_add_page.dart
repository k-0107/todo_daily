import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_daily/ui/task/view_model/task_add_view_model.dart';

class TaskAddPage extends ConsumerWidget {
  TaskAddPage({super.key});
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = TaskAddViewModel(controller, ref);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create New Task',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 249, 248, 241),
      ),
      backgroundColor: const Color.fromARGB(255, 186, 187, 178),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/todo-create.jpg',
              width: 500,
              height: 300,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                width: 400,
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '追加タスク入力  ~ 明日野郎はバカやろう ~',
                      labelStyle: TextStyle(fontSize: 13)),
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
                        viewModel.addTask(context);
                      },
                      icon: const Icon(
                        Icons.note_add,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

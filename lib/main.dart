// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_daily/ui/task/view/task_add_page.dart';
import 'package:todo_daily/ui/task/view/task_edit_page.dart';
import 'package:todo_daily/ui/task/view/task_list_page.dart';

void main() {
  runApp(
    ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  App({super.key});

  final router = GoRouter(
    initialLocation: '/a',
    routes: [
      GoRoute(
        path: '/a',
        builder: (context, state) => const TaskListPage(),
      ),
      GoRoute(
        path: '/b',
        builder: (context, state) => TaskAddPage(),
      ),
      GoRoute(
          path: '/c',
          builder: (context, state) {
            final taskIndex = state.extra as int;
            return TaskEditPage(taskIndex: taskIndex);
          }),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'やることリスト',
    );
  }
}

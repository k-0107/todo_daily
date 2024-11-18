import 'package:go_router/go_router.dart';
import 'package:todo_daily/ui/task/view/task_add_page.dart';
import 'package:todo_daily/ui/task/view/task_edit_page.dart';
import 'package:todo_daily/ui/task/view/task_list_page.dart';

class RouterViewModel {
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const TaskListPage(),
        ),
        GoRoute(
          path: '/t_add',
          builder: (context, state) => TaskAddPage(),
        ),
        GoRoute(
            path: '/t_edit',
            builder: (context, state) {
              final taskIndex = state.extra as int;
              return TaskEditPage(taskIndex: taskIndex);
            }),
      ],
    );
  }
}

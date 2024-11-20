import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_daily/firebase_options.dart';
import 'package:todo_daily/ui/task/view_model/router_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  App({super.key});
  final router = RouterViewModel.createRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'やることリスト',
    );
  }
}

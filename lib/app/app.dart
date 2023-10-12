import 'package:flutter/material.dart';
import 'package:tasklist/screens/task_list_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff07bcb8)),
        useMaterial3: true,
      ),
      home: const TaskListPage(),
    );
  }
}

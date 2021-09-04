import 'package:flutter/material.dart';
import 'package:reminder/pages/add_task_page.dart';
import 'package:reminder/pages/login_page.dart';
import 'package:reminder/pages/profile_page.dart';
import 'package:reminder/pages/tasks_page.dart';
import 'package:reminder/widgets/auth_check.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '(re)Minder',
        theme: ThemeData(primaryColor: Colors.deepPurple[800]),
        initialRoute: '/',
        routes: {
          '/': (context) => AuthCheck(),
          '/login': (context) => LoginPage(),
          '/home': (context) => TasksPage(),
          '/addTask': (context) => AddTaskPage(),
          '/profile': (context) => ProfilePage(),
        });
  }
}

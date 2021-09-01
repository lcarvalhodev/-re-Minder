import 'package:flutter/material.dart';
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
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: AuthCheck(),
    );
  }
}

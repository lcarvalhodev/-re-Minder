import 'package:flutter/material.dart';
import 'package:reminder/models/task.dart';

class DetailsTaskPage extends StatefulWidget {
  final Task task;

  const DetailsTaskPage({Key? key, required this.task}) : super(key: key);

  @override
  _DetailsTaskPageState createState() => _DetailsTaskPageState();
}

class _DetailsTaskPageState extends State<DetailsTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.title),
      ),
    );
  }
}

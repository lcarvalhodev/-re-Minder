import 'package:reminder/models/task.dart';

class TaskRepository {
  static List<Task> tabela = [
    Task(
        title: 'Task1',
        category: 'Category1',
        priority: 'Priority1',
        description: 'Description1'),
    Task(
        title: 'Task2',
        category: 'Category2',
        priority: 'Priority2',
        description: 'Description2'),
    Task(
        title: 'Task3',
        category: 'Category3',
        priority: 'Priority3',
        description: 'Description3'),
    Task(
        title: 'Task4',
        category: 'Category4',
        priority: 'Priority4',
        description: 'Description4'),
  ];
}

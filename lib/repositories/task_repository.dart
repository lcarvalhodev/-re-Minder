import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:reminder/databases/db_firestore.dart';
import 'package:reminder/models/task.dart';
import 'package:reminder/services/auth_service.dart';

class TaskRepository extends ChangeNotifier {
  static List<Task> lista = [];
  late FirebaseFirestore db;
  late AuthService auth;

  TaskRepository({required this.auth}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
    await _readTasks();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  _readTasks() async {
    if (auth.usuario != null && lista.isEmpty) {
      final snapshot =
          await db.collection('usuarios/${auth.usuario!.uid}/tasks').get();
      print(snapshot);
      snapshot.docs.forEach((doc) {
        Task task =
            new Task(title: "", description: "", priority: "", category: "");
        task.id = doc.id;
        task.title = doc.get('title');
        task.description = doc.get('description');
        task.priority = doc.get('priority');
        task.category = doc.get('category');
        task.hour = doc.get('hour');
        task.date = doc.get('date');
        task.location = doc.get('location');
        lista.add(task);
        notifyListeners();
      });
    }
  }

  saveAll(List<Task> tasks) {
    tasks.forEach((task) async {
      if (!lista.any((atual) => atual.title == task.title)) {
        lista.add(task);
        await db.collection('usuarios/${auth.usuario!.uid}/tasks').doc().set({
          'title': task.title,
          'description': task.description,
          'priority': task.priority,
          'category': task.category,
          'date': task.date,
          'hour': task.hour,
          'location': task.location,
        });
      }
    });
    notifyListeners();
  }

  edit(Task task) async {
    // var snapshots = await db.collection('usuarios').snapshots();
    lista.removeWhere((element) => element.id == task.id);
    await db
        .collection('usuarios/${auth.usuario!.uid}/tasks')
        .doc(task.id)
        .update({
      'title': task.title,
      'description': task.description,
      'priority': task.priority,
      'category': task.category,
      'date': task.date,
      'hour': task.hour,
      'location': task.location,
    });
    lista.add(task);
    notifyListeners();
  }

  remove(Task task) async {
    await db
        .collection('usuarios/${auth.usuario!.uid}/tasks')
        .doc(task.id)
        .delete();
    lista.remove(task);
    notifyListeners();
  }
}

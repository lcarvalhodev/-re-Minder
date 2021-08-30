import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reminder/models/task.dart';
import 'package:reminder/pages/add_task_page.dart';
import 'package:reminder/pages/tasks_details_page.dart';
import 'package:reminder/repositories/task_repository.dart';
import 'package:reminder/repositories/user_repository.dart';

class TasksPage extends StatefulWidget {
  TasksPage({Key? key}) : super(key: key);

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final tabela = TaskRepository.tabela;
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  List<Task> selecionadas = [];

  late UserRepository users;

  dinamicAppBar() {
    if (selecionadas.isEmpty) {
      return AppBar(
        title: Text('(re)Minder'),
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              selecionadas = [];
            });
          },
        ),
        title: Text('${selecionadas.length} selecionadas'),
        backgroundColor: Colors.blueGrey[50],
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black87),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
  }

  showDetails(Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailsTaskPage(task: task)),
    );
  }

  @override
  Widget build(BuildContext context) {
    users = Provider.of<UserRepository>(context);
    // users = context.watch<UserRepository>();

    return Scaffold(
      appBar: dinamicAppBar(),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int task) {
          return ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            leading: (selecionadas.contains(tabela[task]))
                ? CircleAvatar(
                    child: Icon(Icons.check),
                  )
                : SizedBox(
                    child: Image.asset('images/avatar.png'),
                    width: 40,
                  ),
            title: Text(
              tabela[task].title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Text(
              tabela[task].description,
              style: TextStyle(fontSize: 15),
            ),
            selected: selecionadas.contains(tabela[task]),
            selectedTileColor: Colors.indigo[50],
            onLongPress: () {
              setState(() {
                (selecionadas.contains(tabela[task]))
                    ? selecionadas.remove(tabela[task])
                    : selecionadas.add(tabela[task]);
              });
            },
            onTap: () => showDetails(tabela[task]),
          );
        },
        padding: EdgeInsets.all(16),
        separatorBuilder: (_, ___) => Divider(),
        itemCount: tabela.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddTaskPage(),
            ),
          ),
        },
      ),
    );
  }
}
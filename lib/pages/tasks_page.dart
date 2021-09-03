import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reminder/models/task.dart';
import 'package:reminder/pages/add_task_page.dart';
import 'package:reminder/pages/tasks_details_page.dart';
import 'package:reminder/repositories/task_repository.dart';
import 'package:reminder/repositories/user_repository.dart';
import 'package:reminder/services/auth_service.dart';
import 'package:reminder/utils/utils.dart';

class TasksPage extends StatefulWidget {
  TasksPage({Key? key}) : super(key: key);

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final tabela = TaskRepository.lista;
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  List<Task> selecionadas = [];

  late UserRepository users;
  late TaskRepository taskRepository;

  showDetails(Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailsTaskPage(task: task)),
    );
  }

  @override
  Widget build(BuildContext context) {
    taskRepository = context.watch<TaskRepository>();
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                accountName: Text(context
                    .read<AuthService>()
                    .usuario!
                    .displayName
                    .toString()),
                currentAccountPicture: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset('images/avatar.png')),
                accountEmail: Text(
                    context.read<AuthService>().usuario!.email.toString())),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Início'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.timer),
              title: Text('Agenda'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.emoji_events),
              title: Text('Pontuação'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Perfil'),
              onTap: () =>
                  Navigator.of(context).pushReplacementNamed('/profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configuração'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                'Sair',
                style: TextStyle(
                  color: Helpers.hexToColor("#A83D35"),
                ),
              ),
              onTap: () {
                context.read<AuthService>().logout();
                Navigator.of(context).pushReplacementNamed('/login');
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('(re)Minder'),
      ),
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
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),
        onPressed: () =>
            {Navigator.of(context).pushReplacementNamed('/addTask')},
      ),
    );
  }
}

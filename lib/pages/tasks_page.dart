import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reminder/models/task.dart';
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
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (_) => DetailsTaskPage(task: task)),
    // );
  }

  orderList() {
    setState(() {
      tabela.sort((a, b) => a.date!.compareTo(b.date!));
    });
  }

  @override
  Widget build(BuildContext context) {
    taskRepository = context.watch<TaskRepository>();
    orderList();
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                  context.read<AuthService>().usuario!.displayName.toString()),
              currentAccountPicture: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset('images/avatar.png')),
              accountEmail: Text(
                context.read<AuthService>().usuario!.email.toString(),
              ),
            ),
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
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 24),
              child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  leading: Icon(
                    Icons.circle_rounded,
                    color: tabela[task].priority == 'Baixa'
                        ? Helpers.hexToColor("#5AC0B9")
                        : tabela[task].priority == 'Média'
                            ? Helpers.hexToColor("#F5BC5B")
                            : Helpers.hexToColor("#F5655B"),
                  ),
                  title: Text(
                    tabela[task].title,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 1, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 15,
                              color: Helpers.hexToColor("#575757"),
                            ),
                            Text(
                              tabela[task].location.toString(),
                              style: TextStyle(
                                  color: Helpers.hexToColor("#272727"),
                                  fontFamily: 'Noto',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.0),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.schedule_outlined,
                              size: 15,
                              color: Helpers.hexToColor("#575757"),
                            ),
                            Text(
                              tabela[task].hour.toString(),
                              style: TextStyle(
                                  color: Helpers.hexToColor("#272727"),
                                  fontFamily: 'Noto',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.0),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  trailing: Column(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Helpers.hexToColor("#C8BEE3"),
                            ),
                          ),
                          child: Text(
                            tabela[task].category,
                            style: TextStyle(
                                color: Helpers.hexToColor("#797482"),
                                fontFamily: 'Noto',
                                fontWeight: FontWeight.w100,
                                fontSize: 11.0),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            tabela[task].date.toString(),
                          ),
                        ),
                      ),
                    ],
                  )
                  // selected: selecionadas.contains(tabela[task]),
                  // selectedTileColor: Colors.indigo[50],
                  // onLongPress: () {
                  //   setState(() {
                  //     (selecionadas.contains(tabela[task]))
                  //         ? selecionadas.remove(tabela[task])
                  //         : selecionadas.add(tabela[task]);
                  //   });
                  // },
                  // onTap: () => showDetails(tabela[task]),
                  ),
            ),
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

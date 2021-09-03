import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reminder/models/task.dart';
import 'package:reminder/pages/tasks_page.dart';
import 'package:reminder/repositories/task_repository.dart';
import 'package:provider/provider.dart';
import 'package:reminder/utils/utils.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _form = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _category = TextEditingController();
  final _date = TextEditingController();
  final _hour = TextEditingController();
  final _priority = TextEditingController();
  final _location = TextEditingController();

  String? _prioritySelected;
  final listPriority = ['Baixa', 'Média', 'Alta'];

  String? _categorySelected;
  final listCategory = ['Pessoal', 'Casa', 'Trabalho'];

  static List<Task> lista = [];
  Task task = Task(category: '', priority: '', title: '', description: '');

  late TaskRepository taskRepository;

  @override
  Widget build(BuildContext context) {
    taskRepository = context.watch<TaskRepository>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Tarefa'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => TasksPage(),
              ),
            ),
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Helpers.hexToColor("#EDEEF0"),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Form(
                  key: _form,
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            cursorColor: Colors.deepPurple,
                            controller: _title,
                            style: TextStyle(
                              fontFamily: 'Noto',
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0,
                              color: Helpers.hexToColor("#00000099"),
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              labelText: 'Título',
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informe o título';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            cursorColor: Colors.deepPurple,
                            controller: _description,
                            style: TextStyle(
                              fontFamily: 'Noto',
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0,
                              color: Helpers.hexToColor("#00000099"),
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              labelText: 'Descrição',
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informe a descrição';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            cursorColor: Colors.deepPurple,
                            controller: _date,
                            style: TextStyle(
                              fontFamily: 'Noto',
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0,
                              color: Helpers.hexToColor("#00000099"),
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              labelText: 'Data',
                              suffixIcon: Icon(
                                Icons.event,
                                color: Helpers.hexToColor("#545454"),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informe a data';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            cursorColor: Colors.deepPurple,
                            controller: _hour,
                            style: TextStyle(
                              fontFamily: 'Noto',
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0,
                              color: Helpers.hexToColor("#00000099"),
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              labelText: 'Horário',
                              suffixIcon: Icon(
                                Icons.schedule_outlined,
                                color: Helpers.hexToColor("#545454"),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informe o horário';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Text(
                                  "Prioridade",
                                  style: TextStyle(
                                    fontFamily: 'Noto',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20.0,
                                    color: Helpers.hexToColor("#00000099"),
                                  ),
                                ),
                                iconSize: 36,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Helpers.hexToColor("#545454"),
                                ),
                                isExpanded: true,
                                value: _prioritySelected,
                                items: listPriority.map(buildMenuItem).toList(),
                                onChanged: (value) => setState(
                                    () => this._prioritySelected = value),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Text(
                                  "Categoria",
                                  style: TextStyle(
                                    fontFamily: 'Noto',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20.0,
                                    color: Helpers.hexToColor("#00000099"),
                                  ),
                                ),
                                iconSize: 36,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Helpers.hexToColor("#545454"),
                                ),
                                isExpanded: true,
                                value: _categorySelected,
                                items: listCategory.map(buildMenuItem).toList(),
                                onChanged: (value) => setState(
                                    () => this._categorySelected = value),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            cursorColor: Colors.deepPurple,
                            controller: _location,
                            style: TextStyle(
                              fontFamily: 'Noto',
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0,
                              color: Helpers.hexToColor("#00000099"),
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              labelText: 'Localização',
                              suffixIcon: Icon(
                                Icons.location_on,
                                color: Helpers.hexToColor("#545454"),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informe a localização';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              _title.clear();
                              _description.clear();
                              _date.clear();
                              _hour.clear();
                              _priority.clear();
                              _category.clear();
                              _location.clear();
                            },
                            child: Text(
                              'DESCARTAR',
                              style: TextStyle(
                                fontFamily: 'Noto',
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                                color: Helpers.hexToColor("#502DA8"),
                              ),
                            ),
                            style: ButtonStyle(
                              side: MaterialStateProperty.all(
                                BorderSide(width: 1, color: Colors.deepPurple),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.deepPurple)),
                            onPressed: () {
                              if (_form.currentState!.validate()) {
                                task.title = _title.value.text.toString();
                                task.description =
                                    _description.value.text.toString();
                                task.category = _categorySelected.toString();
                                task.priority = _prioritySelected.toString();
                                task.hour = _hour.value.text.toString();
                                task.date = _date.value.text.toString();
                                task.location = _location.value.text.toString();

                                lista.add(task);
                                taskRepository.saveAll(lista);
                              }
                            },
                            child: Text(
                              'ADICIONAR',
                              style: TextStyle(
                                  fontFamily: 'Noto',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
            color: Helpers.hexToColor("#575757"),
          ),
        ),
      );
}

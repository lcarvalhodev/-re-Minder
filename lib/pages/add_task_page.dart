import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reminder/models/task.dart';
import 'package:reminder/pages/tasks_page.dart';
import 'package:reminder/repositories/task_repository.dart';
import 'package:provider/provider.dart';

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
                          style:
                              TextStyle(fontSize: 18, color: Colors.deepPurple),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.deepPurple),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple)),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple)),
                            errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
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
                          style:
                              TextStyle(fontSize: 18, color: Colors.deepPurple),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.deepPurple),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple)),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple)),
                            errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
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
                          style:
                              TextStyle(fontSize: 18, color: Colors.deepPurple),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.deepPurple),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple)),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple)),
                            errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            labelText: 'Data',
                            suffixIcon: IconTheme(
                              data: new IconThemeData(color: Colors.deepPurple),
                              child: Icon(Icons.event),
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
                          style:
                              TextStyle(fontSize: 18, color: Colors.deepPurple),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.deepPurple),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple)),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple)),
                            errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            labelText: 'Horário',
                            suffixIcon: IconTheme(
                              data: new IconThemeData(color: Colors.deepPurple),
                              child: Icon(Icons.schedule_outlined),
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
                        child: TextFormField(
                          cursorColor: Colors.deepPurple,
                          controller: _priority,
                          style:
                              TextStyle(fontSize: 18, color: Colors.deepPurple),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.deepPurple),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple)),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple)),
                            errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            labelText: 'Prioridade',
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe a prioridade';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          cursorColor: Colors.deepPurple,
                          controller: _category,
                          style:
                              TextStyle(fontSize: 18, color: Colors.deepPurple),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.deepPurple),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple)),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple)),
                            errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            labelText: 'Categoria',
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe a categoria';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          cursorColor: Colors.deepPurple,
                          controller: _location,
                          style:
                              TextStyle(fontSize: 18, color: Colors.deepPurple),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.deepPurple),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple)),
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple)),
                            errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            labelText: 'Localização',
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
                            'Descartar',
                            style: TextStyle(color: Colors.deepPurple),
                          ),
                          style: ButtonStyle(
                            side: MaterialStateProperty.all(
                              BorderSide(width: 1, color: Colors.deepPurple),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.deepPurple)),
                          onPressed: () {
                            if (_form.currentState!.validate()) {
                              task.title = _title.value.text.toString();
                              task.description =
                                  _description.value.text.toString();
                              task.category = _category.value.text.toString();
                              task.priority = _priority.value.text.toString();
                              task.hour = _hour.value.text.toString();
                              task.date = _date.value.text.toString();
                              task.location = _location.value.text.toString();

                              lista.add(task);
                              taskRepository.saveAll(lista);
                            }
                          },
                          child: Text(
                            'Adicionar',
                            style: TextStyle(color: Colors.white),
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
    );
  }
}

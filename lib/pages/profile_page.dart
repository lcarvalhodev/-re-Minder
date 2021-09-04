import 'package:flutter/material.dart';
import 'package:reminder/repositories/user_repository.dart';
import 'package:reminder/services/auth_service.dart';
import 'package:reminder/utils/utils.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late UserRepository user;

  final formKey = GlobalKey<FormState>();
  final password = TextEditingController();
  final oldPassword = TextEditingController();
  final name = TextEditingController();
  bool loading = false;

  Icon iconPassword = Icon(Icons.visibility);
  Icon iconOldPassword = Icon(Icons.visibility);

  bool passwordVisibible = true;
  bool oldPasswordVisible = true;

  updateUser(
      String email, String oldPassword, String password, String name) async {
    setState(() => loading = true);
    try {
      await context
          .read<AuthService>()
          .updateUser(email, oldPassword, password, name);
          setState(() => loading = false);
      // Navigator.of(context).pushReplacementNamed('/home');
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Helpers.hexToColor("#EDEEEF"),
      appBar: AppBar(
        title: Text('Editar Perfil'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () =>
              {Navigator.of(context).pushReplacementNamed('/home')},
        ),
      ),
      body: SingleChildScrollView(
        child: (loading)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                color: Helpers.hexToColor("#EDEEF0"),
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset('images/avatar.png',
                                width: MediaQuery.of(context).size.width / 6),
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Text(
                                context
                                    .read<AuthService>()
                                    .usuario!
                                    .displayName
                                    .toString(),
                                style: TextStyle(
                                    fontFamily: 'Noto',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 23.0,
                                    color: Helpers.hexToColor("#545454")),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 32.0),
                          child: TextFormField(
                            cursorColor: Colors.deepPurple,
                            initialValue: context
                                .read<AuthService>()
                                .usuario!
                                .email
                                .toString(),
                            style: TextStyle(
                              fontFamily: 'Noto',
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0,
                              color: Helpers.hexToColor("#545454"),
                            ),
                            textAlign: TextAlign.center,
                            readOnly: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              labelStyle: TextStyle(
                                color: Helpers.hexToColor("#545454"),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: TextFormField(
                            controller: name,
                            cursorColor: Colors.deepPurple,
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
                              labelText: "Nome",
                              suffixIcon: Icon(
                                Icons.edit,
                                color: Helpers.hexToColor("#545454"),
                              ),
                              labelStyle: TextStyle(
                                color: Helpers.hexToColor("#545454"),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informe o nome.';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: TextFormField(
                            controller: oldPassword,
                            cursorColor: Colors.deepPurple,
                            style: TextStyle(
                              fontFamily: 'Noto',
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0,
                              color: Helpers.hexToColor("#00000099"),
                            ),
                            obscureText: oldPasswordVisible,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              labelText: "Senha Atual",
                              suffixIcon: IconButton(
                                icon: iconOldPassword,
                                color: Helpers.hexToColor("#545454"),
                                onPressed: () {
                                  setState(() {
                                    oldPasswordVisible = !oldPasswordVisible;
                                    if (oldPasswordVisible == true) {
                                      iconOldPassword = Icon(Icons.visibility);
                                    } else {
                                      iconOldPassword =
                                          Icon(Icons.visibility_off);
                                    }
                                  });
                                },
                              ),
                              labelStyle: TextStyle(
                                color: Helpers.hexToColor("#545454"),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informe uma nova senha.';
                              } else if (value.length < 6) {
                                return 'A senha deve ter no mínimo 6 caracteres.';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: TextFormField(
                            controller: password,
                            cursorColor: Colors.deepPurple,
                            style: TextStyle(
                              fontFamily: 'Noto',
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0,
                              color: Helpers.hexToColor("#00000099"),
                            ),
                            obscureText: passwordVisibible,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              labelText: "Nova Senha",
                              suffixIcon: IconButton(
                                icon: iconPassword,
                                color: Helpers.hexToColor("#545454"),
                                onPressed: () {
                                  setState(() {
                                    passwordVisibible = !passwordVisibible;
                                    if (passwordVisibible == true) {
                                      iconPassword = Icon(Icons.visibility);
                                    } else {
                                      iconPassword = Icon(Icons.visibility_off);
                                    }
                                  });
                                },
                              ),
                              labelStyle: TextStyle(
                                color: Helpers.hexToColor("#545454"),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Informe uma nova senha.';
                              } else if (value.length < 6) {
                                return 'A senha deve ter no mínimo 6 caracteres.';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      name.clear();
                                      password.clear();
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
                                        BorderSide(
                                            width: 1, color: Colors.deepPurple),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
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
                                      if (formKey.currentState!.validate()) {
                                        setState(() {
                                          loading = true;
                                        });
                                        updateUser(
                                            context
                                                .read<AuthService>()
                                                .usuario!
                                                .email
                                                .toString(),
                                            oldPassword.text.toString(),
                                            password.text.toString(),
                                            name.text.toString());
                                      }
                                    },
                                    child: Text(
                                      'ALTERAR',
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
      ),
    );
  }
}

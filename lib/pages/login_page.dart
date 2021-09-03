import 'package:flutter/material.dart';
import 'package:reminder/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:reminder/utils/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final name = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  late String _email, _password, _name, _confirmPassword;
  bool passwordVisibible = true;

  bool isLogin = true;
  late String title;
  late String actionButton;
  late String toggleButton;
  bool loading = false;
  Icon iconPassword = Icon(Icons.visibility);

  @override
  void initState() {
    super.initState();
    setFormAction(true);
  }

  setFormAction(bool action) {
    setState(() {
      isLogin = action;
      if (isLogin) {
        title = 'Bem vindo!';
        actionButton = 'Entrar';
        toggleButton = 'Não tem cadastro? Crie agora.';
      } else {
        title = 'Crie a sua conta';
        actionButton = 'Cadastrar';
        toggleButton = 'Já é cadastrado? Entre agora.';
      }
    });
  }

  login() async {
    setState(() => loading = true);
    try {
      await context.read<AuthService>().login(email.text, password.text);
      Navigator.of(context).pushReplacementNamed('/home');
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  registrar() async {
    setState(() => loading = true);
    try {
      await context
          .read<AuthService>()
          .registrar(email.text, password.text, name.text);
          Navigator.of(context).pushReplacementNamed('/home');
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Helpers.hexToColor("#4F2DA8"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 100),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Image.asset('images/logo.png'),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(24, 24, 24, 12),
                  child: TextFormField(
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    controller: email,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informe o email corretamente.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _email = value.trim();
                      });
                    },
                  ),
                ),
                if (!isLogin)
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    child: TextFormField(
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      controller: name,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        focusedErrorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        labelText: 'Nome',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe o nome corretamente.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _name = value.trim();
                        });
                      },
                    ),
                  ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                  child: TextFormField(
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    controller: password,
                    obscureText: passwordVisibible,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      labelText: 'Senha',
                      suffixIcon: IconButton(
                        icon: iconPassword,
                        color: Colors.white,
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
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informe sua senha.';
                      } else if (value.length < 6) {
                        return 'A senha deve ter no mínimo 6 caracteres.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _password = value.trim();
                      });
                    },
                  ),
                ),
                if (!isLogin)
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    child: TextFormField(
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      controller: confirmPassword,
                      obscureText: passwordVisibible,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        focusedErrorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        labelText: 'Confirmar Senha',
                        suffixIcon: IconButton(
                          icon: iconPassword,
                          color: Colors.white,
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
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (_confirmPassword != _password) {
                          return 'A senhas não são correspondentes.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _confirmPassword = value.trim();
                        });
                      },
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.all(24),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (isLogin) {
                          login();
                        } else {
                          registrar();
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (loading)
                            ? Padding(
                                padding: EdgeInsets.all(16.0),
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.deepPurple,
                                  ),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  actionButton,
                                  style: TextStyle(
                                    color: Helpers.hexToColor("#6200EE"),
                                    fontFamily: 'Noto',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => setFormAction(!isLogin),
                  child: Text(
                    toggleButton,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Noto',
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

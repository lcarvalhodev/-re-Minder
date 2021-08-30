import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/myApp.dart';
import 'package:reminder/repositories/user_repository.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => UserRepository(),
    child: MyApp(),
  ));
}

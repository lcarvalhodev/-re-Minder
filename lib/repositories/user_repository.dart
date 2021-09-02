import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reminder/databases/db_firestore.dart';
import 'package:reminder/models/user.dart';
import 'package:reminder/services/auth_service.dart';

class UserRepository extends ChangeNotifier {
  static late User userAuth;
  late FirebaseFirestore db;
  late AuthService auth;
  late User user;

  _startRepository() async {
    await _startFirestore();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  _readUser() async {
    if (auth.usuario != null) {
      final snapshot =
          await db.collection('usuarios/${auth.usuario!.uid}/users').get();
      snapshot.docs.forEach((doc) {
        user.name = doc.get('name');
        userAuth = user;
        notifyListeners();
      });
    }
  }

  saveUser(User user) async {
    userAuth = user;
    await db
        .collection('usuarios/${auth.usuario!.uid}/users')
        .doc(user.name)
        .set({
      'name': user.name,
    });

    notifyListeners();
  }
}

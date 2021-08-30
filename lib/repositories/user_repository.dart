import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:reminder/models/user.dart';

class UserRepository extends ChangeNotifier {
  List<User> _users = [];

  UnmodifiableListView<User> get user => UnmodifiableListView(_users);

  saveAll(List<User> users) {
    users.forEach((user) {
      _users.add(user);
    });
    notifyListeners();
  }

  remove(User user) {
    _users.remove(user);
    notifyListeners();
  }
}

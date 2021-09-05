import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  User? usuario;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  _updateUserData(String password, String name) async {
    usuario = _auth.currentUser;
    await usuario!.updatePassword(password);
    await usuario!.updateDisplayName(name);
    notifyListeners();
  }

  registrar(String email, String password, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      usuario = result.user;
      await usuario!.updateDisplayName(name);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca.');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este email já está cadastrado.');
      }
    }
  }

  updateUser(
      String email, String oldPassword, String password, String name) async {
    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: oldPassword);
      usuario!.reauthenticateWithCredential(credential);
      _updateUserData(password, name);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta.');
      }
    }
  }

  login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('Email não encontrado. Cadastre-se.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta. Tente novamente.');
      }
    }
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }
}

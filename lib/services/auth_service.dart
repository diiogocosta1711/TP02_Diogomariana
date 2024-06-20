import 'dart:async';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  AuthService._privateConstructor();

  static final AuthService instance = AuthService._privateConstructor();

  final Map<String, dynamic> _users = {};

  String? _loggedInUser;

  String? get loggedInUser => _loggedInUser;

  Future<bool> login(String username, String password) async {
    await Future.delayed(Duration(seconds: 1));
    if (_users.containsKey(username) &&
        _users[username]['password'] == password) {
      _loggedInUser = username;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> register(String username, String password) async {
    await Future.delayed(Duration(seconds: 1));
    if (!_users.containsKey(username)) {
      _users[username] = {'password': password, 'score': 0};
      return true;
    }
    return false;
  }

  void logout() {
    _loggedInUser = null;
    notifyListeners();
  }

  void updateScore(int newScore) {
    if (_loggedInUser != null) {
      _users[_loggedInUser!]['score'] = newScore;
      notifyListeners();
    }
  }

  int? getUserScore(String username) {
    if (_users.containsKey(username)) {
      return _users[username]['score'];
    }
    return null;
  }
}

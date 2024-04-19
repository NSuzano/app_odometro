import 'dart:convert';

import 'package:app_odometro/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  User _user = User();
  List<User> _listUsers = [];
  int _currentPage = 1;
  bool _hasMore = true;

  User get user => _user;
  List<User> get listUsers => _listUsers;
  bool get hasMore => _hasMore;
  int get currentPage => _currentPage;

  void setUser(User user) {
    _user = user;
    notifyListeners();
    saveUserToPrefs(user);
  }

  Future<void> loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    print("Print load from prefs $userJson");
    if (userJson != null) {
      _user = User.fromJson(json.decode(userJson));
      notifyListeners();
    }
  }

  Future<void> cleanUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('user');

    notifyListeners();
  }

  Future<void> saveUserToPrefs(User user) async {
    print(user.token);
    final prefs = await SharedPreferences.getInstance();
    String userJson = json.encode(user.toJson());
    print("Save json: $userJson");
    await prefs.setString('user', userJson);
  }

  Future<void> getAllUsers(int page) async {
    List<User> newListUser = await User.getAllUsersFromApi(user);
    if (newListUser.length < 10) {
      _hasMore = false;
    }
    _listUsers.addAll(newListUser);
    _currentPage++;

    print("HAS MORE : $_hasMore");

    notifyListeners();
  }

  void clearUsers() {
    _listUsers.clear();
    _currentPage = 1;
    _hasMore = true;
    notifyListeners();
  }
}

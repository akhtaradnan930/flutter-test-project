import 'package:flutter/material.dart';
import 'package:flutter_test_project/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  UserModel _user;
  UserModel get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  getUser() async {
    _isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    String email = prefs.getString('email');
    if (token != null) {
      _user = UserModel(id: 1, email: email, token: token);
      _isLoggedIn = true;
    } else {
      _isLoggedIn = false;
    }
    _isLoading = false;
    notifyListeners();
  }

  logout() async {
    _isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    _user = null;
    notifyListeners();
  }
}

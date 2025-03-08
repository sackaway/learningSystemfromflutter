import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String? userEmail;

  void login(String email) {
    userEmail = email;
    notifyListeners();
  }
}

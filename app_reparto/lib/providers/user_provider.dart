import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _userName = '';

  // Getter para acceder al nombre del usuario desde fuera del provider
  String get userName => _userName;

  // Actualizar el nombre del usuario
  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }
}

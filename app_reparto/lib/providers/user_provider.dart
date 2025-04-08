import 'package:flutter/material.dart';

// Proveedor para gestionar el estado del usuario en la aplicación
class UserProvider with ChangeNotifier {
  String _userName = '';  // Almacena el nombre del usuario actual

  // Getter para acceder al nombre del usuario desde fuera del provider
  String get userName => _userName;

  // Método para actualizar el nombre del usuario
  void setUserName(String name) {
    _userName = name;
    notifyListeners();  // Notifica a los widgets que escuchan cambios
  }
}

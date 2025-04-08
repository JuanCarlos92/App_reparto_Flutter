import 'package:flutter/material.dart';
import 'dart:async';

// Proveedor para gestionar el estado y la lógica del temporizador
class TimerProvider extends ChangeNotifier {
  // Variables para almacenar el tiempo
  int _seconds = 0; // Segundos transcurridos
  int _minutes = 0; // Minutos transcurridos
  int _hours = 0; // Horas transcurridas
  bool _isRunning = false; // Estado del temporizador (activo/pausado)
  Timer? _timer; // Objeto Timer para controlar el tiempo

  // Getters para acceder al estado desde fuera del provider
  int get seconds => _seconds;
  int get minutes => _minutes;
  int get hours => _hours;
  bool get isRunning => _isRunning;

  // Método para iniciar el temporizador
  void iniciarTimer() {
    _isRunning = true;
    // Crea un temporizador que se ejecuta cada segundo
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isRunning) {
        _seconds++;

        // Manejo del cambio de minutos
        if (_seconds == 60) {
          _seconds = 0;
          _minutes++;
        }

        // Manejo del cambio de horas
        if (_minutes == 60) {
          _minutes = 0;
          _hours++;
        }

        // Notifica a los widgets que escuchan cambios
        notifyListeners();
      }
    });
  }

  // Método para pausar o reanudar el temporizador
  void pausarTimer() {
    _isRunning = !_isRunning; // Invierte el estado actual
    if (!_isRunning) {
      _timer?.cancel(); // Cancela el timer si se pausa
    } else {
      iniciarTimer(); // Reinicia el timer si se reanuda
    }
    notifyListeners(); // Notifica el cambio de estado
  }

  // Método para finalizar y reiniciar el temporizador
  void finalizarTimer() {
    _timer?.cancel(); // Detiene el timer
    // Reinicia todos los valores
    _seconds = 0;
    _minutes = 0;
    _hours = 0;
    _isRunning = false;
    notifyListeners(); // Notifica los cambios
  }

  @override
  // Limpia los recursos cuando se destruye el provider
  void dispose() {
    _timer?.cancel(); // Asegura que el timer se detenga
    super.dispose();
  }
}

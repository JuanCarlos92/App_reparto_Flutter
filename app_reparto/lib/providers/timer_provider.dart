import 'package:flutter/material.dart';
import 'dart:async';

class TimerProvider extends ChangeNotifier {
  // Variables para almacenar el tiempo
  int _seconds = 0;
  int _minutes = 0;
  int _hours = 0;
  bool _isRunning = false;
  Timer? _timer;
  DateTime? _startTime;

  // Getters para acceder al estado desde fuera del provider
  int get seconds => _seconds;
  int get minutes => _minutes;
  int get hours => _hours;
  bool get isRunning => _isRunning;
  DateTime? get startTime => _startTime;

  // Método para iniciar el temporizador
  void iniciarTimer() {
    _startTime = DateTime.now(); // Guarda el tiempo de inicio
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

        notifyListeners();
      }
    });
  }

  // Método para pausar o reanudar
  void pausarTimer() {
    _isRunning = !_isRunning;
    if (!_isRunning) {
      _timer?.cancel();
    } else {
      iniciarTimer();
    }
    notifyListeners();
  }

  // Método para finalizar
  void finalizarTimer() {
    _timer?.cancel();
    _seconds = 0;
    _minutes = 0;
    _hours = 0;
    _isRunning = false;
    notifyListeners();
  }

  Duration getWorkedTime() {
    return Duration(
      hours: _hours,
      minutes: _minutes,
      seconds: _seconds,
    );
  }

  @override
  // Limpia los recursos
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

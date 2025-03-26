import 'package:flutter/material.dart';
import 'dart:async';

class TimerProvider extends ChangeNotifier {
  int _seconds = 0;
  int _minutes = 0;
  int _hours = 0;
  bool _isRunning = false;
  Timer? _timer;

  int get seconds => _seconds;
  int get minutes => _minutes;
  int get hours => _hours;
  bool get isRunning => _isRunning;

  void iniciarTimer() {
    if (!_isRunning) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _seconds++;

        if (_seconds == 60) {
          _seconds = 0;
          _minutes++;
        }

        if (_minutes == 60) {
          _minutes = 0;
          _hours++;
        }

        notifyListeners();
      });
      _isRunning = true; // Cambia el estado a corriendo
      notifyListeners();
    }
  }

  void pausarTimer() {
    if (_isRunning) {
      _timer?.cancel(); // Detiene el temporizador
      _isRunning = false; // Actualiza el estado
    } else {
      // Reanuda el temporizador al llamar iniciarTimer
      iniciarTimer();
    }
    notifyListeners();
  }

  void finalizarTimer() {
    _timer?.cancel();
    _seconds = 0;
    _minutes = 0;
    _hours = 0;
    _isRunning = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

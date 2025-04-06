import 'package:flutter/material.dart';
import 'dart:async';

class TimerProvider extends ChangeNotifier {
  int _seconds = 0;
  int _minutes = 0;
  int _hours = 0;
  bool _isRunning = false;
  bool _hasStarted = false;
  Timer? _timer;

  int get seconds => _seconds;
  int get minutes => _minutes;
  int get hours => _hours;
  bool get isRunning => _isRunning;
  bool get hasStarted => _hasStarted;

  void iniciarTimer() {
    if (!_hasStarted) {
      _hasStarted = true;
      _isRunning = true;
      _startTimer();
    }
  }

  void _startTimer() {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isRunning) {
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
      }
    });
  }

  void pausarTimer() {
    _isRunning = !_isRunning;
    if (!_isRunning) {
      _timer?.cancel();
    } else {
      _startTimer();
    }
    notifyListeners();
  }

  void finalizarTimer() {
    _timer?.cancel();
    _seconds = 0;
    _minutes = 0;
    _hours = 0;
    _isRunning = false;
    _hasStarted = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
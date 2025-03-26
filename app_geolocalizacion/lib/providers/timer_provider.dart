import 'package:flutter/material.dart';
import 'dart:async';

class TimerProvider extends ChangeNotifier {
  int _seconds = 0;
  int _minutes = 0;
  int _hours = 0;
  bool _isRunning = false;
  Timer? _timer;
  DateTime? _startTime;

  int get seconds => _seconds;
  int get minutes => _minutes;
  int get hours => _hours;
  bool get isRunning => _isRunning;

  void iniciarTimer() {
    if (!_isRunning) {
      _startTime = DateTime.now();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        final now = DateTime.now();
        final difference = now.difference(_startTime!);

        _hours = difference.inHours;
        _minutes = difference.inMinutes % 60;
        _seconds = difference.inSeconds % 60;

        notifyListeners();
      });
      _isRunning = true;
      notifyListeners();
    }
  }

  void pausarTimer() {
    if (_isRunning) {
      _timer?.cancel();
      _isRunning = false;
    } else {
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
    _startTime = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

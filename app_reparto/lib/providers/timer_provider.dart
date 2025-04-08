import 'package:flutter/material.dart';
import 'dart:async';
import '../services/working_time_service.dart';
import '../models/working_time.dart';

class TimerProvider extends ChangeNotifier {
  int _seconds = 0;
  int _minutes = 0;
  int _hours = 0;
  bool _isRunning = false;
  Timer? _timer;
  DateTime? _startTime;
  DateTime? _endTime;

  int get seconds => _seconds;
  int get minutes => _minutes;
  int get hours => _hours;
  bool get isRunning => _isRunning;
  DateTime? get startTime => _startTime;
  DateTime? get endTime => _endTime;

  WorkingTime? getWorkingTimeData() {
    if (_startTime == null || _endTime == null) return null;

    return WorkingTime(
      startTime: _startTime!,
      endTime: _endTime!,
      hours: _hours,
      minutes: _minutes,
      seconds: _seconds,
    );
  }

  Future<void> finalizarTimer() async {
    _timer?.cancel();
    _endTime = DateTime.now();
    
    final workingTime = getWorkingTimeData();
    
    try {
      if (workingTime != null) {
        await WorkingTimeService.saveWorkingTime(workingTime.toJson());
      }
      _resetTimer();
    } catch (e) {
      debugPrint('Error saving working time: $e');
    }
  }

  void iniciarTimer() {
    _isRunning = true;
    _startTime = DateTime.now();
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
      iniciarTimer();
    }
    notifyListeners();
  }

  void _resetTimer() {
    _seconds = 0;
    _minutes = 0;
    _hours = 0;
    _isRunning = false;
    _startTime = null;
    _endTime = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

import 'package:app_reparto/models/work_session.dart';
import 'package:app_reparto/providers/pomodoro_provider.dart';
import 'package:app_reparto/core/services/backend/work_session_service.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class TimerProvider extends ChangeNotifier {
  // Add PomodoroProvider reference
  PomodoroProvider? _pomodoroProvider;

  // Method to set PomodoroProvider
  void setPomodoroProvider(PomodoroProvider provider) {
    _pomodoroProvider = provider;
  }

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
    _startTime = DateTime.now();
    _isRunning = true;

    // Crear una sesión inicial con estado 'working'
    final workSession = WorkSession(
      startTime: _startTime!,
      workedTime: getWorkedTime(),
      status: 'working',
    );

    // Enviar al servidor el estado inicial
    // WorkSessionService.startWorkSession(workSession);

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

        // Notificar al PomodoroProvider del tiempo actual
        _pomodoroProvider?.updateWorkTime(
          Duration(
            hours: _hours,
            minutes: _minutes,
            seconds: _seconds,
          ),
        );

        notifyListeners();
      }
    });
  }

  // Método para pausar o reanudar
  String get status => _isRunning ? 'working' : 'paused';

  // Modificar el método pausarTimer para enviar el estado al servidor
  void pausarTimer() {
    _isRunning = !_isRunning;
    if (!_isRunning) {
      _timer?.cancel();

      // Crear una sesión con el estado actual
      final workSession = WorkSession(
        startTime: _startTime!,
        workedTime: getWorkedTime(),
        status: 'paused',
      );

      // Enviar al servidor
      // WorkSessionService.updateWorkSession(workSession);
    } else {
      iniciarTimer();
      // Crear una sesión con el estado actual
      final workSession = WorkSession(
        startTime: _startTime!,
        workedTime: getWorkedTime(),
        status: 'working',
      );

      // Enviar al servidor
      // WorkSessionService.updateWorkSession(workSession);
    }
    notifyListeners();
  }

  // Método para finalizar
  void finalizarTimer() {
    // Crear una sesión final con el estado y tiempo trabajado
    final workSession = WorkSession(
      startTime: _startTime ?? DateTime.now(),
      endTime: DateTime.now(),
      workedTime: getWorkedTime(),
      status: 'finished',
    );

    // Enviar al servidor que la sesión ha finalizado
    // WorkSessionService.endWorkSession(workSession);

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

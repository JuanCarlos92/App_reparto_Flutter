// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '../core/services/local/notification_service.dart';

class PomodoroProvider extends ChangeNotifier {
  bool _isPomodoroActive = false; // Indica si el Pomodoro está activo
  Duration? _pomodoroDuration; // Duración configurada para cada intervalo
  Duration? _breakDuration; // Duración configurada para el descanso
  Duration _currentWorkTime = Duration.zero; // Tiempo actual de trabajo
  bool _isOnBreak = false;
  DateTime? _breakStartTime;

  // Getters para acceder al estado desde fuera
  bool get isPomodoroActive => _isPomodoroActive;
  Duration? get pomodoroDuration => _pomodoroDuration;
  Duration? get breakDuration => _breakDuration;
  bool get isOnBreak => _isOnBreak;

  // Configura el temporizador Pomodoro con una duración específica
  void setPomodoroTimer(Duration workDuration, Duration breakDuration) {
    _pomodoroDuration = workDuration;
    _breakDuration = breakDuration;
    _isPomodoroActive = true;
    _currentWorkTime = Duration.zero;
    _isOnBreak = false;
    notifyListeners();
  }

  // Actualiza el tiempo trabajado y verifica si es momento de descanso
  // Añadir getter para breakStartTime
  DateTime? get breakStartTime => _breakStartTime;

  // Modificar updateWorkTime para redirigir a la pantalla de descanso
  void updateWorkTime(Duration currentTime) async {
    if (!_isPomodoroActive || _pomodoroDuration == null) return;

    if (_isOnBreak) {
      if (_breakStartTime != null) {
        final breakElapsed = DateTime.now().difference(_breakStartTime!);
        if (breakElapsed >= _breakDuration!) {
          await NotificationService.showWorkNotification();
          disablePomodoro();
          notifyListeners();
        }
      }
    } else {
      _currentWorkTime = currentTime;
      try {
        if (shouldTakeBreak()) {
          _isOnBreak = true;
          _breakStartTime = DateTime.now();
          await NotificationService.showBreakNotification();
          notifyListeners();
        }
      } catch (e) {
        print('Error en notificación: $e');
      }
    }
    notifyListeners();
  }

  // Verifica si es momento de tomar un descanso
  bool shouldTakeBreak() {
    if (!_isPomodoroActive || _pomodoroDuration == null) return false;
    return _currentWorkTime.inSeconds > 0 &&
        _currentWorkTime.inSeconds % _pomodoroDuration!.inSeconds == 0;
  }

  // Desactiva el temporizador Pomodoro y reinicia los valores
  void disablePomodoro() {
    _isPomodoroActive = false;
    _pomodoroDuration = null;
    _breakDuration = null;
    _currentWorkTime = Duration.zero;
    _isOnBreak = false;
    _breakStartTime = null;
    notifyListeners();
  }
}

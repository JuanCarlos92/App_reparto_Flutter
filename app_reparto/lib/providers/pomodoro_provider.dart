import 'package:flutter/material.dart';
import '../core/services/local/notification_service.dart';

class PomodoroProvider extends ChangeNotifier {
  bool _isPomodoroActive = false; // Indica si el Pomodoro está activo
  Duration? _pomodoroDuration; // Duración configurada para cada intervalo
  Duration _currentWorkTime = Duration.zero; // Tiempo actual de trabajo

  // Getters para acceder al estado desde fuera
  bool get isPomodoroActive => _isPomodoroActive;
  Duration? get pomodoroDuration => _pomodoroDuration;

  // Configura el temporizador Pomodoro con una duración específica
  void setPomodoroTimer(Duration duration) {
    _pomodoroDuration = duration;
    _isPomodoroActive = true;
    _currentWorkTime = Duration.zero;
    notifyListeners();
  }

  // Actualiza el tiempo trabajado y verifica si es momento de descanso
  void updateWorkTime(Duration currentTime) async {
    if (!_isPomodoroActive || _pomodoroDuration == null) return;

    _currentWorkTime = currentTime;
    try {
      if (shouldTakeBreak()) {
        await NotificationService.showBreakNotification();
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error en notificación: $e');
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
    _currentWorkTime = Duration.zero;
    notifyListeners();
  }
}

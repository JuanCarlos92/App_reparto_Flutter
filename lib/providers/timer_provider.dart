// ignore_for_file: avoid_print
import 'package:app_reparto/models/work_session.dart';
import 'package:app_reparto/providers/pomodoro_provider.dart';
// import 'package:app_reparto/core/services/backend/work_session_service.dart';
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

  // Método para pausar o reanudar el temporizador
  String get status => _isRunning ? 'working' : 'paused';

  // Modificar el método pausarTimer para enviar el estado al servidor
  void pausarTimer() {
    if (_isRunning) {
      _timer?.cancel();
      _isRunning = false;
  
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

  // Método para finalizar el temporizador
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

  // Método para reanudar si está pausado
  void reanudarTimer() {
    // Cancelar el timer existente si hay uno
    _timer?.cancel();

    // Forzar el estado a running
    _isRunning = true;
    notifyListeners(); // Notificar inmediatamente el cambio de estado

    // Establecer _startTime si es null
    _startTime ??= DateTime.now();

    // Create a work session with current state
    final workSession = WorkSession(
      startTime: _startTime!,
      workedTime: getWorkedTime(),
      status: 'working',
    );

    // Create timer that executes every second
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

      _pomodoroProvider?.updateWorkTime(
        Duration(
          hours: _hours,
          minutes: _minutes,
          seconds: _seconds,
        ),
      );

      notifyListeners();
    });
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

// import 'package:app_reparto/models/work_session.dart';
// import 'package:app_reparto/providers/pomodoro_provider.dart';
// import 'package:app_reparto/core/services/backend/work_session_service.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';

// class TimerProvider extends ChangeNotifier {
//   PomodoroProvider? _pomodoroProvider;

//   void setPomodoroProvider(PomodoroProvider provider) {
//     _pomodoroProvider = provider;
//   }

//   int _seconds = 0;
//   int _minutes = 0;
//   int _hours = 0;
//   bool _isRunning = false;
//   Timer? _timer;
//   DateTime? _startTime;
//   bool _isEnding = false;

//   int get seconds => _seconds;
//   int get minutes => _minutes;
//   int get hours => _hours;
//   bool get isRunning => _isRunning;
//   DateTime? get startTime => _startTime;
//   String get status => _isRunning ? 'activa' : 'pausada';

//   //Cargar jornada activa desde el backend
//   Future<void> cargarJornadaActiva() async {
//     try {
//       final session = await WorkSessionService.getActiveWorkSession();
//       if (session != null) {
//         _startTime = session.startTime;
//         final duration = session.workedTime;

//         _hours = duration.inHours;
//         _minutes = duration.inMinutes % 60;
//         _seconds = duration.inSeconds % 60;
//         _isRunning = session.status == 'activa';

//         if (_isRunning) {
//           _iniciarContador();
//         }

//         notifyListeners();
//       }
//     } catch (e) {
//       print('Error al cargar jornada activa: $e');
//     }
//   }

//   //Iniciar jornada
//   Future<void> iniciarTimer() async {
//     if (_isRunning) {
//       await finalizarTimer();
//     }

//     _startTime = DateTime.now();
//     _isRunning = true;

//     final workSession = WorkSession(
//       startTime: _startTime!,
//       workedTime: getWorkedTime(),
//       status: 'activa',
//       restTime: Duration.zero,
//       rowid: 0,
//     );

//     await WorkSessionService.startWorkSession(workSession);
//     _iniciarContador();
//     notifyListeners();
//   }

//   /// Reanudar o Pausar jornada
//   Future<void> pausarTimer() async {
//     if (_isRunning) {
//       // Pausar
//       _timer?.cancel();
//       _isRunning = false;
//       await WorkSessionService.pauseWorkSession();
//     } else {
//       // Reanudar
//       _isRunning = true;
//       await WorkSessionService.activateWorkSession();
//       _iniciarContador();
//     }

//     notifyListeners();
//   }

//   //Finalizar jornada
//   Future<void> finalizarTimer() async {
//     if (_isEnding) return;
//     _isEnding = true;

//     try {
//       final workSession = WorkSession(
//         startTime: _startTime ?? DateTime.now(),
//         endTime: DateTime.now(),
//         workedTime: getWorkedTime(),
//         status: 'finalizada',
//         restTime: Duration.zero,
//         rowid: 0,
//       );

//       await WorkSessionService.endWorkSession(workSession);

//       _timer?.cancel();
//       _seconds = 0;
//       _minutes = 0;
//       _hours = 0;
//       _isRunning = false;
//       _startTime = null;

//       notifyListeners();
//     } catch (e) {
//       print('Error al finalizar la jornada: $e');
//     } finally {
//       _isEnding = false;
//     }
//   }

//   //Timer local (incrementa cada segundo)
//   void _iniciarContador() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (_) {
//       if (_isRunning) {
//         _seconds++;
//         if (_seconds == 60) {
//           _seconds = 0;
//           _minutes++;
//         }
//         if (_minutes == 60) {
//           _minutes = 0;
//           _hours++;
//         }

//         _pomodoroProvider?.updateWorkTime(
//           Duration(hours: _hours, minutes: _minutes, seconds: _seconds),
//         );

//         notifyListeners();
//       }
//     });
//   }

//   Duration getWorkedTime() {
//     return Duration(hours: _hours, minutes: _minutes, seconds: _seconds);
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
// }

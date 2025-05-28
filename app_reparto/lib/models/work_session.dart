import 'dart:convert';

class WorkSession {
  final DateTime startTime;
  final DateTime? endTime;
  final Duration workedTime;
  final String status;

  // Constructor
  WorkSession({
    required this.startTime,
    this.endTime,
    required this.workedTime,
    required this.status,
  });

  // Método para inicio de sesión
  Map<String, dynamic> toJsonStart() {
    final fechaFormateada = startTime.toUtc().toIso8601String();
    final data = {
      'fecha_inicio': fechaFormateada,
      'estado': status,
    };

    print('Fecha enviada: $fechaFormateada');
    print('JSON a enviar: ${json.encode(data)}');

    return data;
  }

  // Método para finalizar sesión
  Map<String, dynamic> toJsonEnd() {
    return {
      'fecha_inicio': startTime.toIso8601String(),
      'fecha_fin': endTime?.toIso8601String(),
      'tiempo_trabajado_segundos': workedTime.inSeconds,
    };
  }

  // Método para actualizar estado
  Map<String, dynamic> toJsonUpdate() {
    return {
      'estado': status,
    };
  }

  // Método general con todos los datos
  Map<String, dynamic> toJson() {
    return {
      'fecha_inicio': startTime.toIso8601String(),
      'fecha_fin': endTime?.toIso8601String(),
      'tiempo_trabajado_segundos': workedTime.inSeconds,
      'estado': status,
    };
  }
}

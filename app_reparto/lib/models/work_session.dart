// ignore_for_file: avoid_print

class WorkSession {
  final DateTime startTime;
  final DateTime? endTime;
  final Duration workedTime;
  final String status;

  //Constructor
  WorkSession({
    required this.startTime,
    this.endTime,
    required this.workedTime,
    required this.status,
  });

  // Método para inicio de sesión
  Map<String, dynamic> toJsonStart() {
    // Formatear la fecha al formato esperado por el backend
    final formattedDate = startTime.toUtc().toIso8601String();
    print('Fecha formateada para enviar: $formattedDate');

    final jsonData = {
      'fecha_inicio': formattedDate,
      'estado': status,
    };
    print('JSON a enviar: $jsonData');
    return jsonData;
  }

  // Método para finalizar sesión
  Map<String, dynamic> toJsonEnd() {
    return {
      'fecha_inicio': startTime.toUtc().toIso8601String(),
      'fecha_fin': endTime?.toUtc().toIso8601String(),
      'tiempo_trabajado_segundos': workedTime.inSeconds,
    };
  }

  // Método para actualizar estado
  Map<String, dynamic> toJsonUpdate() {
    return {
      'estado': status,
    };
  }
}

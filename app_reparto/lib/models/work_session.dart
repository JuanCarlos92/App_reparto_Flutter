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
    return {
      'startTime': startTime.toIso8601String(),
      'status': status,
    };
  }

  // Método para finalizar sesión
  Map<String, dynamic> toJsonEnd() {
    return {
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'workedTimeSeconds': workedTime.inSeconds,
    };
  }

  // Método para actualizar estado
  Map<String, dynamic> toJsonUpdate() {
    return {
      'status': status,
    };
  }

  // Método general que incluye todos los datos
  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'workedTimeSeconds': workedTime.inSeconds,
      'status': status,
    };
  }
}

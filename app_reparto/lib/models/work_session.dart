class WorkSession {
  final DateTime startTime;
  final DateTime? endTime;
  final Duration workedTime;

  //Constructor
  WorkSession({
    required this.startTime,
    this.endTime,
    required this.workedTime,
  });

  // Método para convertir la instancia a un Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'workedTimeSeconds': workedTime.inSeconds,
    };
  }
}

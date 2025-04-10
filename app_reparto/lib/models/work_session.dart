class WorkSession {
  final DateTime startTime;
  final DateTime? endTime;
  final Duration workedTime;

  WorkSession({
    required this.startTime,
    this.endTime,
    required this.workedTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'workedTimeSeconds': workedTime.inSeconds,
    };
  }
}
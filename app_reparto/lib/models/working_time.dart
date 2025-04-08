class WorkingTime {
  final DateTime startTime;
  final DateTime endTime;
  final int hours;
  final int minutes;
  final int seconds;

  WorkingTime({
    required this.startTime,
    required this.endTime,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  Map<String, dynamic> toJson() {
    return {
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'elapsed_time': {
        'hours': hours,
        'minutes': minutes,
        'seconds': seconds,
        'total_seconds': (hours * 3600) + (minutes * 60) + seconds,
      }
    };
  }
}
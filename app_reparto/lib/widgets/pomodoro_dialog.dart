import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pomodoro_provider.dart';

class PomodoroDialog extends StatelessWidget {
  const PomodoroDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController workController = TextEditingController();
    final TextEditingController breakController = TextEditingController();

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: const Text(
        'Pomodoro',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'Roboto',
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: workController,
            decoration: InputDecoration(
              hintText: 'Inicio de descanso (HH:MM)',
              labelText: '00:30 para 30 minutos',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFD97B1E),
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFD97B1E),
                  width: 2,
                ),
              ),
            ),
            keyboardType: TextInputType.datetime,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: breakController,
            decoration: InputDecoration(
              hintText: 'Tiempo de descanso (HH:MM)',
              labelText: '00:30 para 30 minutos',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFD97B1E),
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFFD97B1E),
                  width: 2,
                ),
              ),
            ),
            keyboardType: TextInputType.datetime,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.read<PomodoroProvider>().disablePomodoro();
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          child: const Text('Desactivar'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => _handleActivate(
            context,
            workController.text,
            breakController.text,
          ),
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          child: const Text('Activar'),
        ),
      ],
    );
  }

  void _handleActivate(
      BuildContext context, String workTime, String breakTime) {
    final workParts = workTime.split(':');
    final breakParts = breakTime.split(':');

    if (workParts.length == 2 && breakParts.length == 2) {
      final workHours = int.tryParse(workParts[0]) ?? 0;
      final workMinutes = int.tryParse(workParts[1]) ?? 0;
      final breakHours = int.tryParse(breakParts[0]) ?? 0;
      final breakMinutes = int.tryParse(breakParts[1]) ?? 0;

      final workDuration = Duration(
        hours: workHours,
        minutes: workMinutes,
      );
      final breakDuration = Duration(
        hours: breakHours,
        minutes: breakMinutes,
      );

      context
          .read<PomodoroProvider>()
          .setPomodoroTimer(workDuration, breakDuration);
    }
    Navigator.pop(context);
  }
}

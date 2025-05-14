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
      title: const Text('Pomodoro'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: workController,
            decoration: const InputDecoration(
              hintText: 'Inicio de descanso (HH:MM)',
              labelText: '00:30 para 30 minutos',
            ),
            keyboardType: TextInputType.datetime,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: breakController,
            decoration: const InputDecoration(
              hintText: 'Tiempo de descanso (HH:MM)',
              labelText: '00:30 para 30 minutos',
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
          child: const Text('Desactivar'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => _handleActivate(
            context,
            workController.text,
            breakController.text,
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

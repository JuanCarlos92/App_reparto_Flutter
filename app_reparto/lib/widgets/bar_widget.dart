// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pomodoro_provider.dart';
import 'pomodoro_dialog.dart';
import 'calendar_popup.dart';

class BarWidget extends StatelessWidget {
  const BarWidget({super.key});

  void _showPomodoroInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const PomodoroDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Botón Pomodoro
            Consumer<PomodoroProvider>(
              builder: (context, pomodoroProvider, child) {
                return IconButton(
                  icon: Icon(
                    pomodoroProvider.isPomodoroActive
                        ? Icons.notifications_active
                        : Icons.notifications_off,
                    color: const Color(0xFFD97B1E),
                    size: 30,
                  ),
                  onPressed: () => _showPomodoroInputDialog(context),
                );
              },
            ),
            // Calendario PopupMenu
            CalendarPopup(
              onDaySelected: (String day) {
                // Aquí puedes implementar la lógica cuando se seleccione un día
                print('Día seleccionado: $day');
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pomodoro_provider.dart';

class BreakScreen extends StatelessWidget {
  const BreakScreen({super.key});

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // No hay botón de retroceso
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 200, 120, 20),
                Color.fromARGB(255, 252, 231, 197),
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.coffee,
                  size: 120,
                  color: Colors.white,
                ),
                const SizedBox(height: 30),
                const Text(
                  '¡Tiempo de Descanso!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Consumer<PomodoroProvider>(
                  builder: (context, provider, child) {
                    if (provider.breakDuration == null || !provider.isOnBreak) {
                      Navigator.of(context).pushReplacementNamed('/timer');
                      return const SizedBox();
                    }

                    final remainingTime = provider.breakDuration! -
                        DateTime.now().difference(provider.breakStartTime!);

                    if (remainingTime.isNegative) {
                      return const Text(
                        "00:00",
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    }

                    return Text(
                      _formatDuration(remainingTime),
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

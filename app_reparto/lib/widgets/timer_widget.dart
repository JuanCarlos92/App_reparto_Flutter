import 'package:app_reparto/core/utils/dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/timer_provider.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key});

  // Método auxiliar para formatear números a dos dígitos (ejemplo: 1 -> "01")
  String _formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      // Decoración del contenedor principal
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 200, 120, 20),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        // Ajusta el tamaño al contenido
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icono del temporizador
          const Icon(
            Icons.timer,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(width: 10),

          // Visualización del tiempo usando Consumer para actualizaciones automáticas
          Consumer<TimerProvider>(
            builder: (context, timerProvider, child) {
              return Text(
                // Formato HH:MM:SS con números de dos dígitos
                '${_formatNumber(timerProvider.hours)}:'
                '${_formatNumber(timerProvider.minutes)}:'
                '${_formatNumber(timerProvider.seconds)}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              );
            },
          ),
          const SizedBox(width: 15),

          // Controles del temporizador (pausar/reanudar y detener)
          Consumer<TimerProvider>(
            builder: (context, timerProvider, child) {
              return Row(
                children: [
                  // Botón de pausar/reanudar
                  Consumer<TimerProvider>(
                    builder: (context, timerProvider, child) {
                      return GestureDetector(
                        onTap: timerProvider.pausarTimer,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            // ignore: deprecated_member_use
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            // Cambia el icono según el estado
                            timerProvider.isRunning
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(width: 8),

                  // Botón de detener y volver a inicio
                  GestureDetector(
                    onTap: () async {
                      if (!context.mounted) return;
                      final bool confirm =
                          await DialogUtils.showConfirmationDialog(
                              context, '¿Finalizar la jornada del día?');

                      if (!context.mounted) return;
                      if (confirm) {
                        timerProvider
                            .finalizarTimer(); // Detiene el temporizador
                        Navigator.pushReplacementNamed(
                            context, '/home'); // Navega a inicio
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.stop,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

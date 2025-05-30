// ignore_for_file: deprecated_member_use

import 'package:app_reparto/core/utils/dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/timer_provider.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key});

  String _formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Cambiado a spaceBetween
        children: [
          // Grupo del reloj y tiempo
          Row(
            children: [
              const Icon(
                Icons.schedule,
                color: Colors.black87,
                size: 40,
              ),
              const SizedBox(width: 8),
              Consumer<TimerProvider>(
                builder: (context, timerProvider, child) {
                  return Text(
                    '${_formatNumber(timerProvider.hours)}:${_formatNumber(timerProvider.minutes)}:${_formatNumber(timerProvider.seconds)}',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  );
                },
              ),
            ],
          ),

          // Grupo de botones
          Consumer<TimerProvider>(
            builder: (context, timerProvider, child) {
              return Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: timerProvider.pausarTimer,
                          child: Icon(
                            timerProvider.isRunning
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            if (!context.mounted) return;
                            final bool confirm =
                                await DialogUtils.showConfirmationDialog(
                                    context, '¿Finalizar la jornada del día?');

                            if (!context.mounted) return;
                            if (confirm) {
                              timerProvider.finalizarTimer();
                              Navigator.pushReplacementNamed(context, '/home');
                            }
                          },
                          child: const Icon(
                            Icons.stop,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
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

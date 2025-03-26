import 'package:app_geolocalizacion/widgets/header_timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_geolocalizacion/providers/timer_provider.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  @override
  void initState() {
    super.initState();
    // Iniciar el temporizador cuando se crea la página
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   context.read<TimerProvider>().iniciarTimer();
    // });
  }

  String _formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.greenAccent, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Encabezado
            const HeaderTimerwidget(),
            // Espacio restante para el contenido centrado
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Texto
                    const Text(
                      'Llevas:',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Consumer<TimerProvider>(
                        builder: (context, timerProvider, child) {
                          return Text(
                            '${_formatNumber(timerProvider.hours)}:${_formatNumber(timerProvider.minutes)}:${_formatNumber(timerProvider.seconds)}',
                            style: const TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Botón Pausa/Reanudar
                    ElevatedButton(
                      onPressed: context.read<TimerProvider>().pausarTimer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Consumer<TimerProvider>(
                        builder: (context, timerProvider, child) {
                          return Text(
                            timerProvider.isRunning ? 'Pausa' : 'Reanudar',
                            style: const TextStyle(fontSize: 20),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Botón Finalizar
                    ElevatedButton(
                      onPressed: () {
                        context.read<TimerProvider>().finalizarTimer();
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Finalizar',
                          style: TextStyle(fontSize: 20)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

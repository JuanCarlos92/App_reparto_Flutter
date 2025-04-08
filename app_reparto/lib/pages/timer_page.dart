import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_reparto/providers/timer_provider.dart';
import '../widgets/button_widget.dart';

// Página que muestra y controla el temporizador de la jornada laboral
class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

// Estado de la página del temporizador
class _TimerPageState extends State<TimerPage> {
  @override
  // Se ejecuta cuando cambian las dependencias, útil para inicializar el temporizador
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // Inicia el temporizador automáticamente si se recibe el argumento correspondiente
    if (arguments != null && arguments['startTimer'] == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final timerProvider = context.read<TimerProvider>();
        // Verifica que el temporizador esté en estado inicial antes de iniciarlo
        if (!timerProvider.isRunning &&
            timerProvider.hours == 0 &&
            timerProvider.minutes == 0 &&
            timerProvider.seconds == 0) {
          timerProvider.iniciarTimer();
        }
      });
    }
  }

  // Función auxiliar para formatear números a dos dígitos
  String _formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior de la aplicación
      appBar: AppBar(
        automaticallyImplyLeading: false, // Oculta el botón de retroceso
        backgroundColor: const Color.fromARGB(255, 200, 120, 20),
        centerTitle: true,
        title: const Text(
          'Control Horario',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Roboto',
            shadows: [
              Shadow(
                blurRadius: 8,
                color: Color.fromRGBO(0, 0, 0, 0.3),
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
      ),
      // Contenedor principal con el temporizador y los controles
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width *
                0.9, // 90% del ancho de la pantalla
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(25, 60, 25, 30),
                ),
                // Contenedor principal del temporizador
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                      border: Border.all(
                        color: const Color.fromARGB(255, 200, 120, 20),
                        width: 1.5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Título del temporizador
                          const Text(
                            'Llevas:',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          // Visualización del tiempo transcurrido
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 25),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 200, 120, 20),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  // ignore: deprecated_member_use
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            // Muestra el tiempo actualizado usando Consumer
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
                          // Botón para pausar o reanudar el temporizador
                          Consumer<TimerProvider>(
                            builder: (context, timerProvider, child) {
                              return ButtonWidget(
                                text: timerProvider.isRunning
                                    ? 'PAUSAR'
                                    : 'REANUDAR',
                                icon: timerProvider.isRunning
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 200, 120, 20),
                                    Color.fromARGB(255, 200, 120, 20),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                onPressed: timerProvider.pausarTimer,
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          // Botón para finalizar la jornada
                          ButtonWidget(
                            text: 'FINALIZAR',
                            icon: Icons.stop,
                            gradient: const LinearGradient(
                              colors: [
                                Colors.red,
                                Colors.red,
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            onPressed: () {
                              context.read<TimerProvider>().finalizarTimer();
                              Navigator.pop(context, '/home');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

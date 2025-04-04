import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_reparto/providers/timer_provider.dart';
import '../widgets/button_widget.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (arguments != null && arguments['startTimer'] == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<TimerProvider>().iniciarTimer();
      });
    }
  }

  String _formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(25, 60, 25, 30),
                ),
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
                          const Text(
                            'Llevas:',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
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
                          // Botón Pausar/Reanudar
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
                          // Botón Finalizar
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

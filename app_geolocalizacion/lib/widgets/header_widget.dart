import 'package:app_geolocalizacion/providers/timer_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  bool isPaused = true; // Variable para controlar el estado de pausa/reanudar

  String _formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }

  // Estilo de texto para el título
  final tituloTextStyle = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 26,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.all(25.0),
      height: 120.0,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black, Color.fromARGB(255, 79, 201, 142)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<TimerProvider>(
                builder: (context, timerProvider, child) {
                  return Text(
                    '${_formatNumber(timerProvider.hours)}:${_formatNumber(timerProvider.minutes)}:${_formatNumber(timerProvider.seconds)}',
                    style: tituloTextStyle,
                  );
                },
              )
            ],
          ),
          Row(
            children: [
              // Botón de pausa/inicio
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(.1),
                ),
                child: IconButton(
                  icon: Icon(
                    isPaused ? Icons.pause : Icons.play_arrow, // Cambiar ícono
                    size: 28,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      isPaused = !isPaused; // Alternar estado al presionar
                    });
                    context.read<TimerProvider>().pausarTimer();
                  },
                ),
              ),
              const SizedBox(width: 10),
              // Botón de detener
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(.1),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.stop,
                    size: 28,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    context.read<TimerProvider>().finalizarTimer();
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:app_geolocalizacion/providers/timer_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeaderVisitswidget extends StatelessWidget {
  const HeaderVisitswidget({super.key});

  String _formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }

  // Estilo de texto para el título: color blanco, negrita, tamaño de fuente 26
  final tituloTextStyle = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 26,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      // Alineación del contenido hacia la parte inferior y centrado
      alignment: Alignment.bottomCenter,
      // Espaciado interno de 25 píxeles alrededor del contenedor
      padding: const EdgeInsets.all(25.0),
      height: 120.0,
      // Fondo de color
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black, Color.fromARGB(255, 79, 201, 142)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Consumer<TimerProvider>(
                builder: (context, timerProvider, child) {
                  return Text(
                    '${_formatNumber(timerProvider.hours)}:${_formatNumber(timerProvider.minutes)}:${_formatNumber(timerProvider.seconds)}',
                    style: tituloTextStyle,
                  );
                },
              ),
            ],
          ),
          Row(
            children: [
              // Primer contenedor
              Container(
                decoration: BoxDecoration(
                  // Bordes redondeados con radio de 15
                  borderRadius: BorderRadius.circular(15),
                  // Fondo negro con opacidad al 10%
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(.1),
                ),
                child: IconButton(
                  // Icono de búsqueda de tamaño 28 y color blanco
                  icon: const Icon(Icons.pause, size: 28, color: Colors.white),
                  onPressed: () {},
                ),
              ),
              // Espacio de 10 píxeles entre los botones
              const SizedBox(width: 10),
              // Segundo contenedor
              Container(
                decoration: BoxDecoration(
                  // Bordes redondeados con radio de 15
                  borderRadius: BorderRadius.circular(15),
                  // Fondo negro con opacidad al 10%
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(.1),
                ),
                child: IconButton(
                  // Icono de notificaciones
                  icon: const Icon(
                    Icons.stop,
                    size: 28,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

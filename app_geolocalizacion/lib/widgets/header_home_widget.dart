import 'package:flutter/material.dart';

class Headerhomewidget extends StatelessWidget {
  const Headerhomewidget({super.key});

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
      height: 120.0, // Altura del contenedor
      // Fondo de color
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black, Color.fromARGB(255, 79, 201, 142)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            // El tamaño de la columna se ajusta al contenido, no ocupa más espacio del necesario
            mainAxisSize: MainAxisSize.min,
            children: [Text("Control Horario", style: tituloTextStyle)],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class HeaderTimerwidget extends StatelessWidget {
  const HeaderTimerwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

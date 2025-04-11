import 'package:app_reparto/widgets/map_widget.dart';
import 'package:app_reparto/widgets/timer_widget.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget {
  final double latitude;
  final double longitude;

  // Constructor
  const LocationScreen({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print('Debug - LocationScreen coordinates: $latitude, $longitude');

    // Si las coordenadas son inválidas, muestra un mensaje de error
    if (latitude == 0.0 ||
        longitude == 0.0 ||
        latitude < -90 ||
        latitude > 90 ||
        longitude < -180 ||
        longitude > 180) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 200, 120, 20),
          title: const Text('Error de ubicación'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Coordenadas no válidas para este cliente',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Latitud: $latitude, Longitud: $longitude',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    // Estructura principal de la pantalla
    return Scaffold(
      // Barra superior de la aplicación
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 200, 120, 20),
        centerTitle: true,
        title: const Text(
          'Ubicación',
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

      // Cuerpo principal de la pantalla
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Sección superior con el widget del temporizador
            Container(
              padding: const EdgeInsets.fromLTRB(25, 60, 25, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TimerWidget(), // Widget del temporizador
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(height: 8.5),

            // Sección inferior con el mapa
            Expanded(
              child: Center(
                child: SizedBox(
                  // 90% del ancho de la pantalla
                  width: MediaQuery.of(context).size.width * 0.9,
                  // Decoración del contenedor del mapa
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 252, 231, 197),
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                      // Borde naranja alrededor del contenedor
                      border: Border.all(
                        color: const Color.fromARGB(255, 200, 120, 20),
                        width: 1.5,
                      ),
                    ),
                    // Widget del mapa con padding
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: MapWidget(
                        latitude: latitude,
                        longitude: longitude,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

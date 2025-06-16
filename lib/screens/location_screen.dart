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
    print('Location - Localizacion coordenadas: $latitude, $longitude');

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
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            // Botón de retroceso
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            // Padding superior para el logo
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image.asset(
                'assets/reparto360.png',
                height: 60,
                fit: BoxFit.contain,
              ),
            ),
            // Sección superior con el widget del temporizador
            Container(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
              child: const Column(
                children: [
                  TimerWidget(),
                ],
              ),
            ),
            const SizedBox(height: 5),
            // Texto "Ubicación" alineado a la izquierda
            const Padding(
              padding: EdgeInsets.only(left: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Ubicación',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ),
            // Mapa expandido sin contenedor
            Expanded(
              child: MapWidget(
                latitude: latitude,
                longitude: longitude,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

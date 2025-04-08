import 'package:app_reparto/widgets/map_widget.dart';
import 'package:app_reparto/widgets/timer_widget.dart';
import 'package:flutter/material.dart';

// Widget para mostrar la ubicación del cliente con un mapa y temporizador
class LocationWidget extends StatelessWidget {
  // Coordenadas geográficas del cliente
  final double latitude; // Latitud del cliente
  final double longitude; // Longitud del cliente

  // Constructor que requiere las coordenadas
  const LocationWidget({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    // Estructura principal de la pantalla
    return Scaffold(
      // Barra superior de la aplicación
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(
            255, 200, 120, 20), // Color naranja personalizado
        centerTitle: true, // Centra el título
        title: const Text(
          'Ubicación',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Roboto',
            // Efecto de sombra para el texto
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
                  width: MediaQuery.of(context).size.width *
                      0.9, // 90% del ancho de la pantalla
                  child: Container(
                    // Decoración del contenedor del mapa
                    decoration: BoxDecoration(
                      color: Color.fromARGB(
                          255, 252, 231, 197), // Color de fondo claro
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      // Sombra suave alrededor del contenedor
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
            const SizedBox(height: 20), // Espacio inferior
          ],
        ),
      ),
    );
  }
}

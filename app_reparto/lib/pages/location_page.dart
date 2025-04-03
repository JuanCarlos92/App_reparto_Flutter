import 'package:app_reparto/widgets/map_widget.dart';
import 'package:app_reparto/widgets/timer_widget.dart';
import 'package:flutter/material.dart';

class LocationPage extends StatelessWidget {
  final double latitude;
  final double longitude;

  const LocationPage({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    // Estructura principal
    return Scaffold(
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
      // Contenedor principal toda la pantalla
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Contenedor superior con el temporizador
            Container(
              padding: const EdgeInsets.fromLTRB(25, 60, 25, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TimerWidget(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(height: 8.5),

            // Contenedor inferior con el widget del mapa
            Expanded(
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
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
                      border: Border.all(
                        color: const Color.fromARGB(255, 200, 120, 20),
                        width: 1.5,
                      ),
                    ),
                    // Contenedor de detalles del cliente
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

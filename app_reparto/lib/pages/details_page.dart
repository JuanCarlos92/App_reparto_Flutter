import 'package:app_reparto/widgets/clients_details_widget.dart';
import 'package:app_reparto/widgets/timer_widget.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String clientName;
  final String clientAddress;
  final double latitude;
  final double longitude;

  const DetailsPage({
    super.key,
    required this.clientName,
    required this.clientAddress,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    // Estructura principal
    return Scaffold(
      // Contenedor principal ocupando toda la pantalla
      body: Container(
        // Configura el fondo de la pantalla con un degradado
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0D3A21),
              Color(0xFF1E5631),
              Color(0xFF4FC98E),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        // Centra su contenido en la pantalla
        child: Column(
          // Centrar horizontalmente
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Contenedor superior con el temporizador
            Container(
              padding: const EdgeInsets.fromLTRB(25, 60, 25, 20),
              child: Column(
                // Centrar verticalmente
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TimerWidget(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(height: 8.5),

            // Contenedor inferior con el widget de detalles del cliente
            Expanded(
              // Colores de fondo y sombra
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 91, 92, 91),
                      Color.fromARGB(255, 232, 238, 235),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),

                // Contenedor de detalles del cliente
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: ClientDetailsWidget(
                    clientName: clientName,
                    clientAddress: clientAddress,
                    latitude: latitude,
                    longitude: longitude,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:app_reparto/widgets/detail_widget.dart';
import 'package:app_reparto/widgets/timer_widget.dart';
import 'package:flutter/material.dart';

// Página que muestra los detalles de un cliente específico
class DetailScreen extends StatelessWidget {
  // Propiedades para almacenar la información del cliente
  final String clientName; // Nombre del cliente
  final String clientAddress; // Dirección del cliente
  final String clientTown; // Ciudad del cliente

  // Constructor que requiere los datos básicos del cliente
  const DetailScreen({
    super.key,
    required this.clientName,
    required this.clientAddress,
    required this.clientTown,
  });

  @override
  Widget build(BuildContext context) {
    // Estructura principal de la página
    return Scaffold(
      // Barra superior de la aplicación
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 200, 120, 20),
        centerTitle: true,
        title: const Text(
          'Detalles del cliente',
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
      // Contenedor principal que ocupa toda la pantalla
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Sección superior donde se muestra el temporizador
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

            // Sección principal con los detalles del cliente
            Expanded(
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width *
                      0.9, // 90% del ancho de la pantalla
                  child: Container(
                    // Decoración del contenedor de detalles
                    decoration: BoxDecoration(
                      color:
                          Color.fromARGB(255, 252, 231, 197), // Color de fondo
                      borderRadius: const BorderRadius.all(
                          Radius.circular(40)), // Bordes redondeados
                      boxShadow: [
                        BoxShadow(
                          // Sombra del contenedor
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                      border: Border.all(
                        // Borde del contenedor
                        color: const Color.fromARGB(255, 200, 120, 20),
                        width: 1.5,
                      ),
                    ),
                    // Widget que muestra los detalles del cliente
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: DetailWidget(
                        clientName: clientName,
                        clientAddress: clientAddress,
                        clientTown: clientTown,
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

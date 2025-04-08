import 'package:flutter/material.dart';

// Widget para mostrar los detalles de un cliente
class DetailWidget extends StatelessWidget {
  // Propiedades para almacenar la información del cliente
  final String clientName;     // Nombre del cliente
  final String clientAddress;  // Dirección del cliente
  final String clientTown;     // Ciudad del cliente

  // Constructor que requiere todos los datos del cliente
  const DetailWidget({
    super.key,
    required this.clientName,
    required this.clientAddress,
    required this.clientTown,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),  // Espaciado uniforme alrededor del contenido
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,  // Alinea los textos a la izquierda
        children: [
          // Muestra el nombre del cliente con estilo destacado
          Text(
            'Nombre: $clientName',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),  // Espacio vertical entre elementos
          // Muestra la ciudad del cliente
          Text(
            'Ciudad: $clientTown',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),  // Espacio vertical entre elementos
          // Muestra la dirección del cliente
          Text(
            'Dirección: $clientAddress',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

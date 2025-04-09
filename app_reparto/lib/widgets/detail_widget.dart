import 'package:flutter/material.dart';

class DetailWidget extends StatelessWidget {
  final String clientName;
  final String clientAddress;
  final String clientTown;

  const DetailWidget({
    super.key,
    required this.clientName,
    required this.clientAddress,
    required this.clientTown,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Espaciado uniforme alrededor del contenido
      padding: const EdgeInsets.all(16.0),
      child: Column(
        // Alinea los textos a la izquierda
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Muestra el nombre del cliente con estilo destacado
          Text(
            'Nombre: $clientName',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          // Muestra la ciudad del cliente
          Text(
            'Ciudad: $clientTown',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
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

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
          // Nombre
          const Text(
            'Nombre:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            clientName,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),

          // Ciudad
          const Text(
            'Ciudad:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            clientTown,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),

          // Dirección
          const Text(
            'Dirección:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            clientAddress,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

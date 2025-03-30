import 'package:app_reparto/widgets/clients_map_widget.dart';
import 'package:flutter/material.dart';

class ClientDetailsWidget extends StatelessWidget {
  final String clientName;
  final String clientAddress;
  final double latitude;
  final double longitude;

  const ClientDetailsWidget({
    super.key,
    required this.clientName,
    required this.clientAddress,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nombre: $clientName',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'Dirección: $clientAddress',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          ClientMapWidget(
            latitude: latitude,
            longitude: longitude,
          ),
        ],
      ),
    );
  }
}

import 'package:app_geolocalizacion/pages/client_details_page.dart';
import 'package:app_geolocalizacion/providers/clients_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // Para formatear la distancia

class ClientsListWidget extends StatelessWidget {
  const ClientsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final clientsProvider = Provider.of<ClientsProvider>(context);
    final clients = clientsProvider.clients;

    return Expanded(
      child: clients.isEmpty
          ? const Center(
              child: Text(
                'No hay clientes disponibles',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(25),
              itemCount: clients.length,
              itemBuilder: (context, index) {
                final client = clients[index];

                // Formatear la distancia
                final distanceFormatted = NumberFormat("#0.00")
                    .format(client.distanceToDelivery / 1000); // En kilómetros

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ClientDetailsPage(
                                clientName: client.name,
                                clientAddress: client.address,
                                latitude: client.latitude,
                                longitude: client.longitude,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          client.name,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              client.address,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Distancia: $distanceFormatted km',
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

import 'package:app_geolocalizacion/pages/clients_details_page.dart';
import 'package:app_geolocalizacion/providers/clients_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                        child: Text(
                          client.address,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                          overflow: TextOverflow.ellipsis,
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

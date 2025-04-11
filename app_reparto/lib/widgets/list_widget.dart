import 'package:app_reparto/screens/detail_screen.dart';
import 'package:app_reparto/screens/location_screen.dart';
import 'package:app_reparto/providers/clients_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({super.key});

  // Método para formatear la duración en minutos o horas
  String _formatDuration(int seconds) {
    if (seconds < 60) {
      return '$seconds seg';
    } else if (seconds < 3600) {
      return '${(seconds / 60).round()} min';
    } else {
      return '${(seconds / 3600).round()} h';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtiene la instancia del provider de clientes
    final clientsProvider = Provider.of<ClientsProvider>(context);
    final clients = clientsProvider.clients;

    // Muestra un indicador de carga mientras se obtienen los datos
    if (clientsProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Muestra mensaje de error si existe alguno
    if (clientsProvider.error.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 60,
              color: Color.fromARGB(255, 200, 120, 20),
            ),
            const SizedBox(height: 20),
            Text(
              clientsProvider.error,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 200, 120, 20),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    // Muestra mensaje cuando no hay clientes disponibles
    return clients.isEmpty
        ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_off,
                  size: 60,
                  color: Color.fromARGB(255, 200, 120, 20),
                ),
                SizedBox(height: 20),
                Text(
                  'No hay clientes disponibles',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 200, 120, 20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )

        // Construye la lista de clientes si hay datos disponibles
        : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: clients.length,
            itemBuilder: (context, index) {
              final client = clients[index];

              // Tarjeta de cliente individual
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 252, 231, 197),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      // Botón de ubicación que abre el mapa
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LocationScreen(
                                latitude: client.latitude,
                                longitude: client.longitude,
                              ),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 200, 120, 20),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                // ignore: deprecated_member_use
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Información básica del cliente
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              client.name,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              client.address,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            // Inside the ListView.builder itemBuilder
                            Text(
                              '${_formatDuration(client.durationInSeconds)}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Botón para ver detalles del cliente
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 200, 120, 20),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              // ignore: deprecated_member_use
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    clientName: client.name,
                                    clientAddress: client.address,
                                    clientTown: client.town,
                                  ),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 12),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}

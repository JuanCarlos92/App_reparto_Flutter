import 'package:app_geolocalizacion/models/clients.dart';
import 'package:flutter/material.dart';

class ClientsProvider extends ChangeNotifier {
  // Lista de clientes
  List<Client> _clients = [];

  // Getter para la lista
  List<Client> get clients => _clients;

  // Método para actualizar los clientes
  void setClients(List<Client> newClients) {
    _clients = newClients;
    // Notifica a los widgets para que se actualicenk
    notifyListeners();
  }

  // Simulación de un llamado al backend (API)
  Future<void> fetchClientsFromBackend() async {
    // Simulando una llamada HTTP y respuesta JSON
    await Future.delayed(const Duration(seconds: 2));
    final response = [
      {
        "name": "Cliente A",
        "address": "Dirección A",
        "latitude": 40.7128,
        "longitude": -74.0060
      },
      {
        "name": "Cliente B",
        "address": "Dirección B",
        "latitude": 34.0522,
        "longitude": -118.2437
      },
      {
        "name": "Cliente C",
        "address": "Dirección C",
        "latitude": 41.8781,
        "longitude": -87.6298
      },
    ];

    // Convierte la respuesta a una lista de objetos Cliente
    List<Client> fetchedClients =
        response.map((data) => Client.fromJson(data)).toList();

    // Actualiza la lista de clientes
    setClients(fetchedClients);
  }
}

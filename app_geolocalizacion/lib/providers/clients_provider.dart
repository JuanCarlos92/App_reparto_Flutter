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
    // Simulando una llamada HTTP y respuesta JSON // Simulación de datos del backend
    await Future.delayed(const Duration(seconds: 2));
    final response = [
      {"name": "Cliente A", "address": "Dirección A"},
      {"name": "Cliente B", "address": "Dirección B"},
      {"name": "Cliente C", "address": "Dirección C"},
      {"name": "Cliente A", "address": "Dirección A"},
      {"name": "Cliente B", "address": "Dirección B"},
      {"name": "Cliente C", "address": "Dirección C"},
      {"name": "Cliente A", "address": "Dirección A"},
      {"name": "Cliente B", "address": "Dirección B"},
      {"name": "Cliente C", "address": "Dirección C"},
      {"name": "Cliente A", "address": "Dirección A"},
      {"name": "Cliente B", "address": "Dirección B"},
      {"name": "Cliente C", "address": "Dirección C"},
    ];

    // Convierte la respuesta a una lista de objetos Cliente
    List<Client> fetchedClients =
        response.map((data) => Client.fromJson(data)).toList();

    // Actualiza la lista de clientes
    setClients(fetchedClients);
  }
}

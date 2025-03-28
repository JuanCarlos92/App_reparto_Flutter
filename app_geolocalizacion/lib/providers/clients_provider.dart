import 'package:app_geolocalizacion/models/client.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ClientsProvider extends ChangeNotifier {
  // Lista de clientes
  List<Client> _clients = [];

  // Getter para la lista
  List<Client> get clients => _clients;

  // Método para actualizar los clientes
  void setClients(List<Client> newClients) {
    _clients = newClients;
    notifyListeners();
  }

  // Simulación de un llamado al backend (API)
  Future<void> fetchClientsFromBackend() async {
    try {
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
          "latitude": 37.0522,
          "longitude": -130.2437
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

      // Obtén la ubicación actual del repartidor
      Position position = await Geolocator.getCurrentPosition(
        // ignore: deprecated_member_use
        desiredAccuracy: LocationAccuracy.high,
      );

      // Calcula las distancias entre el repartidor y los clientes
      for (var client in fetchedClients) {
        double distance = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          client.latitude,
          client.longitude,
        );
        client.distanceToDelivery = distance; // Asigna la distancia al cliente
      }

      // Ordena los clientes por distancia (menor a mayor)
      fetchedClients
          .sort((a, b) => a.distanceToDelivery.compareTo(b.distanceToDelivery));

      // Actualiza la lista de clientes
      setClients(fetchedClients);
    } catch (e) {
      debugPrint('Error al obtener clientes o calcular distancias: $e');
    }
  }

  // Método para eliminar un cliente y recalcular las distancias
  Future<void> removeClient(Client clientToRemove) async {
    try {
      // Elimina el cliente de la lista
      _clients.removeWhere((client) => client.name == clientToRemove.name);

      // Obtén la ubicación actual del repartidor
      Position position = await Geolocator.getCurrentPosition(
        // ignore: deprecated_member_use
        desiredAccuracy: LocationAccuracy.high,
      );

      // Recalcula las distancias para los clientes restantes
      for (var client in _clients) {
        double distance = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          client.latitude,
          client.longitude,
        );
        client.distanceToDelivery = distance; // Actualiza la distancia
      }

      // Ordena los clientes restantes por distancia (menor a mayor)
      _clients
          .sort((a, b) => a.distanceToDelivery.compareTo(b.distanceToDelivery));

      // Notifica a los widgets para que se actualicen
      notifyListeners();
    } catch (e) {
      debugPrint('Error al eliminar cliente o recalcular distancias: $e');
    }
  }
}

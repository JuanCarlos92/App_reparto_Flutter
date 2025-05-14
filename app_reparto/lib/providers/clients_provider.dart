import 'package:app_reparto/models/client.dart';
import 'package:app_reparto/core/services/backend/client_service.dart';
// import 'package:app_reparto/core/services/api/distance_service.dart';
import 'package:app_reparto/core/services/local/geolocation_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../core/services/api/graphHopper_service.dart';

class ClientsProvider extends ChangeNotifier {
  // Servicios necesarios para la gestión de clientes y geolocalización
  final ClientService _clientService = ClientService();
  final GeolocationService _geolocationService = GeolocationService();
  final GraphhopperService _graphhopperService = GraphhopperService();

  List<Client> _clients = [];
  bool _isLoading = false;
  String _error = '';
  List<Client> get clients => _clients;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchClientsFromBackend() async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      final fetchedClients = await _clientService.getClients();
      _clients = fetchedClients;

      // Actualizar duracion despues de actualizar clientes
      await updateClientsWithDuration();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Método para obtener los clientes desde el backend
  Future<void> updateClientsWithDuration() async {
    try {
      final position = await _geolocationService.determinarPosition();

      // ignore: avoid_print
      print('Client - Actualizando tiempos para ${_clients.length} clientes');

      // Actualizar la duración para cada cliente
      // for (var client in _clients) {
      //   final duration = await DistanceService.getDistanceMatrix(
      //     position.latitude,
      //     position.longitude,
      //     client.latitude,
      //     client.longitude,
      //   );
      //   client.durationInSeconds = duration;
      // }
      // Actualizar la duración para cada cliente usando GraphhopperService
      for (var client in _clients) {
        final result = await _graphhopperService.drawRouteAndGetTime(
          LatLng(position.latitude, position.longitude),
          client.latitude,
          client.longitude,
        );

        client.durationInSeconds = result['duration'];
      }

      // Ordenar la lista por tiempos de viaje
      _clients
          .sort((a, b) => a.durationInSeconds.compareTo(b.durationInSeconds));

      notifyListeners();
    } catch (e) {
      // ignore: avoid_print
      print('Error actualizando duraciones: $e');
    }
  }
}

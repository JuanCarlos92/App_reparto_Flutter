// ignore_for_file: avoid_print

import 'package:app_reparto/models/client.dart';
import 'package:geolocator/geolocator.dart';
import '../core/services/api/graphhopper_time_service.dart';
import '../core/services/local/client_service_local.dart';
import 'package:app_reparto/core/services/local/geolocation_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClientsProvider extends ChangeNotifier {
  // Servicios necesarios para la gestión de clientes y geolocalización
  // final ClientService _clientService = ClientService();
  final ClientServiceLocal _clientServiceLocal = ClientServiceLocal();
  final GeolocationService _geolocationService = GeolocationService();
  final GraphhopperTimeService _graphhopperTimeService =
      GraphhopperTimeService();

  List<Client> _clients = [];
  bool _isLoading = false;
  String _error = '';
  bool _isUpdatingDurations = false;
  List<Client> get clients => _clients;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchClientsFromBackend() async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      final fetchedClients = await _clientServiceLocal.getClients();
      _clients = fetchedClients;
      
      // Actualizar duraciones inmediatamente
      await updateClientsWithDuration();
      
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateClientsWithDuration() async {
    if (_isUpdatingDurations || _clients.isEmpty) return;

    try {
      _isUpdatingDurations = true;
      final position = await _geolocationService.determinarPosition();

      // Actualizar todos los clientes en paralelo
      await Future.wait(
        _clients.map((client) => _updateClientDuration(client, position))
      );

      // Ordenar la lista por tiempos de viaje
      _clients.sort((a, b) {
        if (a.durationInSeconds <= 0 && b.durationInSeconds <= 0) return 0;
        if (a.durationInSeconds <= 0) return 1;
        if (b.durationInSeconds <= 0) return -1;
        return a.durationInSeconds.compareTo(b.durationInSeconds);
      });

      notifyListeners();
    } catch (e) {
      print('Error actualizando duraciones: $e');
    } finally {
      _isUpdatingDurations = false;
    }
  }

  Future<void> _updateClientDuration(Client client, Position position) async {
    try {
      final duration = await _graphhopperTimeService.getEstimatedTime(
        LatLng(position.latitude, position.longitude),
        client.latitude,
        client.longitude,
      );
      client.durationInSeconds = duration ?? -1;
    } catch (e) {
      print('Error actualizando tiempo para cliente ${client.id}: $e');
      client.durationInSeconds = -1;
    }
  }
}

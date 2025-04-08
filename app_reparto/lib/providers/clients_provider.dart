import 'package:app_reparto/models/client.dart';
import 'package:app_reparto/services/client_service.dart';
// import 'package:app_reparto/services/geolocation_service.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';

// Proveedor para gestionar el estado y la lógica de los clientes en la aplicación
class ClientsProvider extends ChangeNotifier {
  // Servicios necesarios para la gestión de clientes y geolocalización
  final ClientService _clientService =
      ClientService(); // Servicio para operaciones con clientes
  // final GeolocationService _geolocationService = GeolocationService();

  // Variables de estado
  List<Client> _clients = []; // Lista de clientes
  bool _isLoading = false; // Indicador de carga
  String _error = ''; // Mensaje de error si existe

  // Getters para acceder al estado desde fuera del provider
  List<Client> get clients => _clients; // Obtener lista de clientes
  bool get isLoading => _isLoading; // Obtener estado de carga
  String get error => _error; // Obtener mensaje de error

  // Método para obtener los clientes desde el backend
  Future<void> fetchClientsFromBackend() async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      print('Debug - Fetching clients from backend...'); // Debug print
      final fetchedClients = await _clientService.getClients();
      print('Debug - Response from backend: $fetchedClients'); // Debug print
      print('Debug - Fetched clients count: ${fetchedClients.length}');

      if (fetchedClients.isEmpty) {
        print('Debug - No clients received from backend'); // Debug print
        _clients = [];
        _isLoading = false;
        notifyListeners();
        return;
      }

      print('Debug - Setting clients in provider'); // Debug print
      _clients = fetchedClients;
    } catch (e) {
      print('Debug - Error in fetchClientsFromBackend: $e'); // Debug print
      _error = e.toString();
      debugPrint('Error al obtener clientes: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Se eliminó el método refreshTravelTimes ya que no es necesario
}

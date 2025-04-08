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
      // Inicia el proceso de carga
      _isLoading = true;
      _error = '';
      notifyListeners(); // Notifica a los widgets que escuchan cambios

      // Obtiene los clientes del servicio
      final fetchedClients = await _clientService.getClients();
      // ignore: avoid_print
      print(
          'Fetched clients count: ${fetchedClients.length}'); // Log de depuración

      // Si no hay clientes, limpia la lista y termina
      if (fetchedClients.isEmpty) {
        _clients = [];
        _isLoading = false;
        notifyListeners();
        return;
      }

      // Actualiza la lista de clientes
      _clients = fetchedClients;
    } catch (e) {
      // Manejo de errores
      _error = e.toString();
      debugPrint('Error al obtener clientes: $e');
    } finally {
      // Finaliza el proceso de carga
      _isLoading = false;
      notifyListeners(); // Notifica a los widgets que escuchan cambios
    }
  }

  // Se eliminó el método refreshTravelTimes ya que no es necesario
}

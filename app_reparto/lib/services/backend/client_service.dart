import 'package:app_reparto/config/backend_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/client.dart';
import '../local/token_service.dart';

class ClientService {
  // Obtener lista de clientes de un trabajador logueado
  Future<List<Client>> getClients() async {
    try {
      final token = await TokenService.getToken();
      if (token == null) {
        throw Exception(
            'No se ha encontrado el token. Por favor inicia sesión.');
      }

      final url = Uri.parse('${BackendConfig.url}/clients');

      // actualiza headers con Authorization
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      // Procesa la respuesta exitosa
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body.isEmpty) {
          return [];
        }

        final decoded = json.decode(response.body);
        if (decoded is! List) {
          return [];
        }

        // Procesa cada cliente de la lista
        List<Client> clients = [];
        for (var item in decoded) {
          try {
            if (item != null && item is Map<String, dynamic>) {
              // ignore: avoid_print
              print('debug - Latitud raw: ${item['latitud']}');
              // ignore: avoid_print
              print('debug - Longitud raw: ${item['longitud']}');

              double lat = 0.0;
              double lng = 0.0;

              // Maneja diferentes formato de numeros
              if (item['latitud'] != null) {
                lat = item['latitud'] is num
                    ? (item['latitud'] as num).toDouble()
                    : double.tryParse(item['latitud'].toString()) ?? 0.0;
              }

              if (item['longitud'] != null) {
                lng = item['longitud'] is num
                    ? (item['longitud'] as num).toDouble()
                    : double.tryParse(item['longitud'].toString()) ?? 0.0;
              }

              final Map<String, dynamic> safeJson = {
                'id': (item['id'] ?? '').toString(),
                'name': (item['name'] ?? '').toString(),
                'town': (item['town'] ?? '').toString(),
                'address': (item['address'] ?? '').toString(),
                'latitud': lat,
                'longitud': lng,
              };

              clients.add(Client.fromJson(safeJson));
            }
          } catch (e) {
            // ignore: avoid_print
            print('Error - processing client: $e');
            continue;
          }
        }

        return clients;
      } else if (response.statusCode == 401) {
        throw Exception(
            'Trabajador no válido o sin permisos para ver los clientes.');
      } else {
        throw Exception(
            'Error al obtener los clientes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  //Metodo para eliminar un cliente
  Future<bool> deleteClient(String clientId) async {
    try {
      final token = await TokenService.getToken();
      if (token == null) {
        throw Exception(
            'No se ha encontrado el token. Por favor inicia sesión.');
      }
      final url = Uri.parse('${BackendConfig.url}/clients/$clientId');

      // actualiza headers con Authorization
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      // Procesa la respuesta exitosa
      switch (response.statusCode) {
        case 200:
        case 204:
          return true;
        case 401:
          throw Exception('Token no válido o expirado');
        case 403:
          throw Exception('No tiene permisos para eliminar este cliente');
        case 404:
          throw Exception('Cliente no encontrado');
        default:
          throw Exception('Error al eliminar cliente: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }
}

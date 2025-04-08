import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/client.dart';
import 'token_service.dart';
import '../config/api_config.dart';

// Servicio para gestionar las operaciones relacionadas con los clientes
class ClientService {
  // Método para obtener la lista de clientes desde el servidor
  Future<List<Client>> getClients() async {
    try {
      final token = await TokenService.getToken();

      // Add debug print for token
      print('Debug - Token: $token');

      if (token == null) {
        throw Exception(
            'No se ha encontrado el token. Por favor inicia sesión.');
      }

      final url = Uri.parse('${ApiConfig.baseUrl}/clients');
      print('Debug - URL completa: $url');

      // Updated headers with Authorization
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      // Add debug print for response
      print('Debug - Response status code: ${response.statusCode}');
      print('Debug - Response headers: ${response.headers}');

      // Procesa la respuesta exitosa
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Response body: ${response.body}');

        if (response.body.isEmpty) {
          print('Response body is empty');
          return [];
        }

        final decoded = json.decode(response.body);
        print('Debug - Decoded JSON type: ${decoded.runtimeType}');
        print('Debug - Decoded JSON content: $decoded');

        if (decoded is! List) {
          print(
              'Debug - Decoded JSON is not a List, it is: ${decoded.runtimeType}');
          return [];
        }

        // Procesa cada cliente de la lista
        List<Client> clients = [];
        for (var item in decoded) {
          try {
            if (item != null && item is Map<String, dynamic>) {
              // Crea un mapa con valores seguros y por defecto
              final Map<String, dynamic> safeJson = {
                'id': (item['id'] ?? '').toString(),
                'name': (item['name'] ?? '').toString(),
                'town': (item['town'] ?? '').toString(),
                'address': (item['address'] ?? '').toString(),
                'latitud':
                    double.tryParse(item['latitud']?.toString() ?? '0') ?? 0.0,
                'longitud':
                    double.tryParse(item['longitud']?.toString() ?? '0') ?? 0.0,
              };

              // Crea y añade el objeto Cliente
              clients.add(Client.fromJson(safeJson));
            }
          } catch (e) {
            // Manejo de errores por cliente individual
            // ignore: avoid_print
            print('Error procesando cliente individual: $e');
            continue;
          }
        }

        return clients;
      } else if (response.statusCode == 401) {
        // Modificado para reflejar el problema de ID de trabajador
        throw Exception(
            'ID de trabajador no válido o sin permisos para ver los clientes.');
      } else {
        // Manejo de otros errores de la API
        throw Exception(
            'Error al obtener los clientes: ${response.statusCode}');
      }
    } catch (e) {
      // Manejo de errores de conexión
      throw Exception('Error de conexión: $e');
    }
  }
}

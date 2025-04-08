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
      // Obtiene el token de autenticación
      final token = await TokenService.getToken();

      // Verifica si existe un token válido
      if (token == null) {
        throw Exception(
            'No se ha encontrado el token. Por favor inicia sesión.');
      }

      // Realiza la petición GET al endpoint de clientes
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/clients'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'DOLAPIKEY': token, // Token de autenticación
        },
      );

      // Procesa la respuesta exitosa
      if (response.statusCode == 200 || response.statusCode == 201) {
        // ignore: avoid_print
        print('Response body: ${response.body}'); // Log de depuración

        // Verifica si la respuesta está vacía
        if (response.body.isEmpty) {
          // ignore: avoid_print
          print('Response body is empty'); // Log de depuración
          return [];
        }

        // Decodifica la respuesta JSON
        final decoded = json.decode(response.body);
        // ignore: avoid_print
        print('Decoded JSON: $decoded'); // Log de depuración
        if (decoded is! List) {
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
                'array_options': item['array_options'] is Map
                    ? item['array_options']
                    : {'opcion1': '', 'opcion2': '', 'opcion3': ''}
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
        // Manejo de sesión expirada
        await TokenService.clearToken();
        throw Exception('Sesión expirada. Por favor inicia sesión nuevamente.');
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

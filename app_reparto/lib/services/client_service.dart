import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/client.dart';
import 'token_service.dart';
import '../config/api_config.dart';

class ClientService {
  // Método para obtener la lista de clientes desde el servidor
  Future<List<Client>> getClients(String username) async {
    try {
      final token = await TokenService.getToken(username);
      if (token == null) {
        throw Exception(
            'No se ha encontrado el token. Por favor inicia sesión.');
      }

      final url = Uri.parse('${ApiConfig.baseUrl}/clients');

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
              print('debug - Latitud raw: ${item['latitud']}');
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
}

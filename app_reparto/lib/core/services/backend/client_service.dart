// ignore_for_file: avoid_print
import 'package:app_reparto/core/config/backend.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../models/client.dart';
import '../local/token_service.dart';

class ClientService {
  // Obtener lista de clientes de un trabajador logueado
  Future<List<Client>> getClients() async {
    try {
      final token = await TokenService.getToken();
      if (token == null) {
        throw 'Por favor inicia sesión';
      }

      final url = Uri.parse('${Backend.url}/thirdparties');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body.isEmpty) return [];

        final decoded = json.decode(response.body);
        print('\n====RESPUESTA DEL BACKEND====');
        print(const JsonEncoder.withIndent('  ').convert(decoded));
        print('=========================\n');

        if (decoded is! List) return [];

        List<Client> clients = [];
        for (var item in decoded) {
          try {
            if (item != null && item is Map<String, dynamic>) {
              final client = Client.fromApiResponse(item);
              print('\n====DATOS DEL CLIENTE=====');
              print(client.toString());
              print('==========================\n');
              clients.add(client);
            }
          } catch (e) {
            print('Error - procesando clientes: $e');
            continue;
          }
        }

        return clients;
      } else if (response.statusCode == 401) {
        throw 'Trabajador sin permisos para ver los clientes.';
      } else {
        throw 'Error al obtener los clientes: ${response.statusCode}';
      }
    } catch (e) {
      throw ('$e');
    }
  }

  //Metodo para eliminar un cliente
  Future<bool> deleteClient(String clientId) async {
    try {
      final token = await TokenService.getToken();
      if (token == null) {
        throw 'Por favor inicia sesión';
      }
      final url = Uri.parse('${Backend.url}/clientes/$clientId');

      // actualiza headers con Authorization
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      // Procesa la respuesta
      switch (response.statusCode) {
        case 200:
        case 204:
          return true;
        case 403:
          throw 'No tiene permisos para eliminar este cliente';
        case 404:
          throw 'Cliente no encontrado';
        default:
          throw 'Error al eliminar cliente (código ${response.statusCode}): ${response.body}';
      }
    } catch (e) {
      throw Exception('$e');
    }
  }
}

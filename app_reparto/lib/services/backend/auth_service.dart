import 'package:app_reparto/config/backend_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../local/token_service.dart';

class AuthService {
  // Método login
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      // Realiza la petición POST al endpoint de login
      final response = await http.post(
        Uri.parse('${BackendConfig.url}/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        // Envía las credenciales en formato JSON
        body: json.encode({'usuario': username, 'contrasena': password}),
      );

      if (response.statusCode == 200) {
        // Si la autenticación es exitosa
        final data = json.decode(response.body);

        // Verifica si el token de autenticación está presente
        if (data.containsKey('DOLAPIKEY')) {
          String token = data['DOLAPIKEY'];
          await TokenService.setToken(token); //Almacena token
          return data;
        } else {
          // Error si no se encuentra el token
          throw Exception('Token no encontrado en la respuesta');
        }
      } else if (response.statusCode == 401) {
        // Manejo de credenciales inválidas
        await TokenService.clearToken();
        throw Exception('Credenciales inválidas. Inicia sesión nuevamente.');
      } else {
        // Manejo de otros errores de autenticación
        throw Exception(
            'Error de autenticación: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // Manejo de errores inesperados
      throw Exception('$e');
    }
  }
}

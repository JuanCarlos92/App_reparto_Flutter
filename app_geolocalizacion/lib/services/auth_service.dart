import 'package:http/http.dart' as http;
import 'dart:convert';
import 'token_service.dart';

class AuthService {
  // URL base de la API
  static const String baseUrl = 'https://dirty-shrimps-stare.loca.lt';

  // Método de login
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await http.post(
        // Realiza una petición HTTP POST a la API de login
        Uri.parse('$baseUrl/login'),
        // Especifica que se envía JSON en la solicitud
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        // Convierte los datos en JSON
        body: json.encode({'usuario': username, 'contrasena': password}),
      );

      if (response.statusCode == 200) {
        // Si el login es exitoso (código 200)
        final data = json.decode(response.body); // Decodifica la respuesta JSON
        // Guarda el token en el almacenamiento
        await TokenService.setToken(data['token']);
        return data;
      } else if (response.statusCode == 401) {
        // Si las credenciales son inválidas (código 401)
        await TokenService.clearToken(); // Borra el token si existía
        throw Exception(
            'Credenciales inválidas. Por favor, inicia sesión nuevamente.');
      } else {
        // Cualquier otro error
        throw Exception(
          'Error de autenticación: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      // Captura errores de conexión u otros errores inesperados
      throw Exception('Error de conexión: $e');
    }
  }

  // Método de registro
  Future<Map<String, dynamic>> register(
      String username, String password, String domain) async {
    try {
      final response = await http.post(
        // Realiza una petición HTTP POST a la API de registro
        Uri.parse('$baseUrl/register'),
        // Especifica que se envía JSON en la solicitud
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        // Convierte los datos en JSON
        body: json.encode(
            {'usuario': username, 'contrasena': password, 'dominio': domain}),
      );

      if (response.statusCode == 201) {
        // Si el registro es exitoso (código 201)
        final data = json.decode(response.body); // Decodifica la respuesta JSON
        // Guarda el token en el almacenamiento
        await TokenService.setToken(data['token']);
        return data;
      } else {
        // Cualquier otro error en el registro
        throw Exception(
          'Error de registro: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      // Captura errores de conexión u otros errores inesperados
      throw Exception('Error de conexión: $e');
    }
  }
}

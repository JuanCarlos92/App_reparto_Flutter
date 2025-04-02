import 'package:http/http.dart' as http;
import 'dart:convert';
import 'token_service.dart';

class AuthService {
  static const String baseUrl = 'https://3f78-80-102-248-37.ngrok-free.app';

  // Método de login
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({'usuario': username, 'contrasena': password}),
      );

      if (response.statusCode == 200) {
        // Si el login es exitoso...
        final data = json.decode(response.body);

        // Verificar que el token está presente
        if (data.containsKey('DOLAPIKEY')) {
          String token = data['DOLAPIKEY'];

          // Guarda el token en el almacenamiento
          await TokenService.setToken(token);
          return data;
        } else {
          throw Exception('Token no encontrado en la respuesta');
        }
      } else if (response.statusCode == 401) {
        // Si las credenciales son inválidas...
        await TokenService.clearToken();
        throw Exception(
            'Credenciales inválidas. Por favor, inicia sesión nuevamente.');
      } else {
        // Cualquier otro error
        throw Exception(
            'Error de autenticación: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // Captura errores de conexión u otros errores inesperados
      throw Exception('Error de conexión: $e');
    }
  }
}

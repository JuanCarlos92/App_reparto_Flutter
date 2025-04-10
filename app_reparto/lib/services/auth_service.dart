import 'package:http/http.dart' as http;
import 'dart:convert';
import 'token_service.dart';
import '../config/api_config.dart';

class AuthService {
  // Método para realizar el inicio de sesión
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      // Realiza la petición POST al endpoint de login
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/login'),
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
          // Almacena el token asociado al usuario
          await TokenService.setToken(username, token);
          // Guarda el último usuario que inició sesión
          await TokenService.setLastLoggedUser(username);
          return data;
        } else {
          // Error si no se encuentra el token
          throw Exception('Token no encontrado en la respuesta');
        }
      } else if (response.statusCode == 401) {
        // Manejo de credenciales inválidas
        await TokenService.clearToken(username);
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

  // Método para cerrar sesión de un usuario específico
  Future<void> logout(String username) async {
    await TokenService.clearToken(username);
  }

  // Método para cerrar todas las sesiones
  Future<void> logoutAll() async {
    await TokenService.clearAllTokens();
  }
}

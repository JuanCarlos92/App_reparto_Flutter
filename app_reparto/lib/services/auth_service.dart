import 'package:http/http.dart' as http;
import 'dart:convert';
import 'token_service.dart';
import '../config/api_config.dart';

// Servicio para manejar la autenticación de usuarios
class AuthService {
  // Método para realizar el inicio de sesión
  // Retorna un Map con la respuesta del servidor
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      // Realiza la petición POST al endpoint de login
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/login'),
        headers: {
          'Content-Type': 'application/json',  // Tipo de contenido JSON
          'Accept': 'application/json',        // Acepta respuesta JSON
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

          // Almacena el token para futuras peticiones
          await TokenService.setToken(token);
          return data;  // Retorna los datos de la respuesta
        } else {
          // Error si no se encuentra el token
          throw Exception('Token no encontrado en la respuesta');
        }
      } else if (response.statusCode == 401) {
        // Manejo de credenciales inválidas
        await TokenService.clearToken();  // Limpia el token almacenado
        throw Exception(
            'Credenciales inválidas. Por favor, inicia sesión nuevamente.');
      } else {
        // Manejo de otros errores de autenticación
        throw Exception(
            'Error de autenticación: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // Manejo de errores de conexión o inesperados
      throw Exception('Error de conexión: $e');
    }
  }
}

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'token_service.dart';

class AuthService {
  static const String baseUrl = 'https://2830-80-102-248-37.ngrok-free.app/';

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
        // Si el login es exitoso...
        final data = json.decode(response.body);
        // Guarda el token en el almacenamiento
        await TokenService.setToken(data['token']);
        return data;
      } else if (response.statusCode == 401) {
        // Si las credenciales son inválidas...
        await TokenService.clearToken();
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
        // Realiza una solicitud HTTP POST a la API de registro
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
            {'usuario': username, 'contrasena': password, 'dominio': domain}),
      );

      // Verificar si la respuesta fue exitosa (código 201)
      if (response.statusCode == 201) {
        // Si el registro es exitoso...
        final data = json.decode(response.body);
        // Guardar el token en el almacenamiento o realizar alguna otra acción
        await TokenService.setToken(data['token']);
        return data; // Devuelve los datos del usuario y el token
      } else {
        // Si la respuesta es un error, muestra el error correspondiente
        throw Exception('Error en el registro: ${response.body}');
      }
    } catch (e) {
      // Manejar errores de conexión u otros errores
      throw Exception('Error de conexión o servidor: $e');
    }
  }
}

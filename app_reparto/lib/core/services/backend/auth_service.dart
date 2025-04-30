// ignore_for_file: avoid_print
import 'package:app_reparto/core/config/backend.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../local/token_service.dart';

class AuthService {
  // Método login
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      print('[AUTH] Iniciando proceso de login para usuario: $username');
      // Realiza la petición POST al endpoint de login
      final response = await http.post(
        Uri.parse('${Backend.url}/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        // Envía las credenciales en formato JSON
        body: json.encode({'login': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        print('[AUTH] Login exitoso - Procesando respuesta');
        // Si la autenticación es exitosa
        final data = json.decode(response.body);
        print('[AUTH] Cuerpo de la respuesta decodificado: $data');

        // Verifica si el token de autenticación está presente
        if (data.containsKey('success') &&
            data['success'].containsKey('token')) {
          String token = data['success']['token'];
          print('[AUTH] Token recibido correctamente');
          await TokenService.setToken(token);
          return data;
        } else {
          // Error si no se encuentra el token
          throw Exception('Token no encontrado en la respuesta');
        }
      } else if (response.statusCode == 401) {
        print('[AUTH] Error 401: Credenciales inválidas');
        // Manejo de credenciales inválidas
        await TokenService.clearToken();
        throw Exception('Credenciales inválidas. Inicia sesión nuevamente.');
      } else {
        // Manejo de otros errores de autenticación
        throw Exception(
            'Error de autenticación: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('[AUTH] Error inesperado durante el login: $e');
      // Manejo de errores inesperados
      throw Exception('$e');
    }
  }
}

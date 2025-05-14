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
      print('Login: $username, Password: $password');

      final response = await http.post(
        Uri.parse('${Backend.url}/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({'login': username, 'password': password}),
      );

      print('[AUTH] Código de respuesta: ${response.statusCode}');
      print('[AUTH] Cuerpo de la respuesta: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('[AUTH] Login exitoso - Procesando respuesta');
        print('[AUTH] Cuerpo de la respuesta decodificado: $data');

        // Ajuste para formato Dolibarr actual
        if (data.containsKey('DOLAPIKEY')) {
          String token = data['DOLAPIKEY'];
          print('[AUTH] Token recibido correctamente: $token');
          await TokenService.setToken(token);
          return data;
        } else {
          throw Exception('Token no encontrado en la respuesta');
        }
      } else if (response.statusCode == 401) {
        await TokenService.clearToken();
        throw Exception('Credenciales inválidas. Inicia sesión nuevamente.');
      } else {
        throw Exception(
            'Error de autenticación: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('[AUTH] Error inesperado durante el login: $e');
      throw Exception('$e');
    }
  }
}

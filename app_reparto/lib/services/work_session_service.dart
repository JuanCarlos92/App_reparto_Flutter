// Importaciones necesarias para el servicio
import 'dart:convert';
import 'package:app_reparto/config/api_config.dart';
import 'package:http/http.dart' as http;
import '../models/work_session.dart';
import 'token_service.dart';

class WorkSessionService {
  static Future<void> startWorkSession() async {
    try {
      // Obtiene el token de autenticación
      final token = await TokenService.getToken();
      if (token == null) throw Exception('No authentication token found');

      // Realiza la petición POST
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/work-sessions/start'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        // Envía la hora de inicio actual
        body: json.encode({
          'startTime': DateTime.now().toIso8601String(),
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Error al iniciar la jornada: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> endWorkSession(WorkSession session) async {
    try {
      // Obtiene el token de autenticación
      final token = await TokenService.getToken();
      if (token == null) throw Exception('No authentication token found');

      // Realiza la petición POST
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/work-sessions/end'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        // Envía los datos de la sesión completa (inicio, fin y tiempo trabajado)
        body: json.encode(session.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Error al finalizar la jornada: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }
}

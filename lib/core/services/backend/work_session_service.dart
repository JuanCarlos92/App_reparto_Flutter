// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_reparto/core/config/backend.dart';
import '../../../models/work_session.dart';
import '../local/token_service.dart';

class WorkSessionService {
  static Future<void> startWorkSession(WorkSession session) async {
    try {
      print('START SESSION DATA:');
      print(json.encode(session.toJsonStart()));

      final token = await TokenService.getToken();
      if (token == null) throw Exception('Token no encontrado');

      final response = await http.post(
        Uri.parse('${Backend.url}/work-sessions/start'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(session.toJsonStart()),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Error al iniciar la jornada: ${response.body}');
      }
    } catch (e) {
      print('Error en la solicitud: $e');
      rethrow;
    }
  }

  static Future<void> endWorkSession(WorkSession session) async {
    try {
      print('END SESSION DATA:');
      print(json.encode(session.toJsonEnd()));

      final token = await TokenService.getToken();
      if (token == null) throw Exception('Token no encontrado');

      final response = await http.post(
        Uri.parse('${Backend.url}/work-sessions/end'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(session.toJsonEnd()),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Error al finalizar la jornada: ${response.body}');
      }
    } catch (e) {
      print('Error en la solicitud: $e');
      rethrow;
    }
  }

  static Future<void> updateWorkSession(WorkSession session) async {
    try {
      print('UPDATE SESSION DATA:');
      print(json.encode(session.toJsonUpdate()));

      final token = await TokenService.getToken();
      if (token == null) throw Exception('Token no encontrado');

      final response = await http.post(
        Uri.parse('${Backend.url}/work-sessions/update'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(session.toJsonUpdate()),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception('Error al actualizar la jornada: ${response.body}');
      }
    } catch (e) {
      print('Error en la solicitud: $e');
      rethrow;
    }
  }
}

// import 'dart:convert';
// import 'package:app_reparto/core/config/backend.dart';
// import 'package:http/http.dart' as http;
// import '../../../models/work_session.dart';
// import '../local/token_service.dart';

// class WorkSessionService {
//   static Future<void> startWorkSession(WorkSession session) async {
//     // Obtiene el token
//     final token = await TokenService.getToken();
//     if (token == null) throw Exception('Token no encontrado');

//     print('START SESSION DATA:');
//     print(json.encode(session.toJsonStart(token)));
//     // Realiza la petición POST
//     final response = await http.post(
//       Uri.parse('${Backend.url}/jornadas/start'),
//       headers: {
//         'DOLAPIKEY': token,
//         'Content-Type': 'application/json',
//       },
//       // Envía la hora de inicio y el estado
//       body: json.encode(session.toJsonStart(token)),
//     );

//     if (response.statusCode != 200) {
//       throw Exception('Error al iniciar la jornada: ${response.body}');
//     }
//   }

//   static Future<void> pauseWorkSession() async {
//     // Obtiene el token
//     final token = await TokenService.getToken();
//     if (token == null) throw Exception('Token no encontrado');

//     print('PAUSE SESSION DATA:');
//     // Realiza la petición POST
//     final response = await http.post(
//       Uri.parse('${Backend.url}/jornadas/pause'),
//       headers: {
//         'DOLAPIKEY': token,
//         'Content-Type': 'application/json',
//       },
//       // Envía el estado de la sesión actualizada
//       body: json.encode({
//         'token': token,
//         "estado": "pausada",
//       }),
//     );

//     if (response.statusCode != 200) {
//       throw Exception('Error al pausar la jornada: ${response.body}');
//     }
//   }

//   static Future<void> activateWorkSession() async {
//     print('ACTIVATE SESSION DATA:');

//     // Obtiene el token
//     final token = await TokenService.getToken();
//     if (token == null) throw Exception('Token no encontrado');

//     // Realiza la petición POST
//     final response = await http.post(
//       Uri.parse('${Backend.url}/jornadas/activate'),
//       headers: {
//         'DOLAPIKEY': token,
//         'Content-Type': 'application/json',
//       },
//       // Envía el estado de la sesión actualizada
//       body: json.encode({
//         'token': token,
//         "estado": "activa",
//       }),
//     );

//     if (response.statusCode != 200) {
//       throw Exception('Error al reanudar la jornada: ${response.body}');
//     }
//   }

//   static Future<void> endWorkSession(WorkSession session) async {
//     // Obtiene el token de autenticación
//     final token = await TokenService.getToken();
//     if (token == null) throw Exception('token no encontrado');

//     print('END SESSION DATA:');
//     print(json.encode(session.toJsonEnd(token)));

//     // Realiza la petición POST
//     final response = await http.post(
//       Uri.parse('${Backend.url}/jornadas/end'),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//       // Envía los datos de la sesión completa (inicio, fin y tiempo trabajado)
//       body: json.encode(session.toJsonEnd(token)),
//     );

//     if (response.statusCode != 200) {
//       throw Exception('Error al finalizar la jornada: ${response.body}');
//     }
//   }

//   static Future<WorkSession?> getActiveWorkSession() async {
//     // Obtiene el token
//     final token = await TokenService.getToken();
//     if (token == null) throw Exception('Token no encontrado');

//     // Realiza la petición GET
//     final response = await http.get(
//       Uri.parse('${Backend.url}/jornadas/active'),
//       headers: {
//         'DOLAPIKEY': token,
//         'Content-Type': 'application/json',
//       },
//     );

//     if (response.statusCode == 200) {
//       print('GET ACTIVE SESSION DATA:');
//       print(response.body);
//     }

//     if (response.statusCode != 200) {
//       throw Exception('Error al obtener la jornada activa: ${response.body}');
//     }

//     // Procesa la respuesta
//     final data = json.decode(response.body);
//     if (data['estado'] == 'sin_jornada_activa') {
//       return null;
//     }

//     return WorkSession.fromJson(data);
//   }

//   static Future<WorkSession?> getWorkedTime() async {
//     // Obtiene el token
//     final token = await TokenService.getToken();
//     if (token == null) throw Exception('Token no encontrado');

//     // Realiza la petición GET
//     final response = await http.get(
//       Uri.parse('${Backend.url}/update-tiempo-trabajo'),
//       headers: {
//         'DOLAPIKEY': token,
//         'Content-Type': 'application/json',
//       },
//     );
//     if (response.statusCode == 200) {
//       print('GET Tiempo trabajado:');
//       print(response.body);
//     }

//     if (response.statusCode != 200) {
//       throw Exception('Error al obtener el tiempo trabajado: ${response.body}');
//     }

//     return WorkSession.fromJson(json.decode(response.body));
//   }
// }

// // ignore_for_file: avoid_print
// import 'dart:convert';
// import 'package:app_reparto/core/config/backend.dart';
// import 'package:http/http.dart' as http;
// import '../../../models/work_session.dart';
// import '../local/token_service.dart';

// class WorkSessionService {
//   static Future<void> startWorkSession(WorkSession session) async {
//     try {
//       print('START SESSION DATA:');
//       print(json.encode(session.toJsonStart()));

//       // Obtiene el token
//       final token = await TokenService.getToken();
//       if (token == null) throw Exception('Token no encontrado');

//       // Realiza la petición POST
//       final response = await http.post(
//         Uri.parse('${Backend.url}/work-sessions/start'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//         // Envía la hora de inicio y el estado
//         body: json.encode(session.toJsonStart()),
//       );

//       if (response.statusCode != 200) {
//         throw Exception('Error al iniciar la jornada: ${response.body}');
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }

//   static Future<void> endWorkSession(WorkSession session) async {
//     try {
//       print('END SESSION DATA:');
//       print(json.encode(session.toJsonEnd()));

//       // Obtiene el token de autenticación
//       final token = await TokenService.getToken();
//       if (token == null) throw Exception('token no encontrado');

//       // Realiza la petición POST
//       final response = await http.post(
//         Uri.parse('${Backend.url}/work-sessions/end'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//         // Envía los datos de la sesión completa (inicio, fin y tiempo trabajado)
//         body: json.encode(session.toJsonEnd()),
//       );

//       if (response.statusCode != 200) {
//         throw Exception('Error al finalizar la jornada: ${response.body}');
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }

//   static Future<void> updateWorkSession(WorkSession session) async {
//     try {
//       print('UPDATE SESSION DATA:');
//       print(json.encode(session.toJsonUpdate()));

//       // Obtiene el token de autenticación
//       final token = await TokenService.getToken();
//       if (token == null) throw Exception('Token no encontrado');

//       // Realiza la petición POST
//       final response = await http.post(
//         Uri.parse('${Backend.url}/work-sessions/update'),
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Content-Type': 'application/json',
//         },
//         // Envía el estado de la sesión actualizada
//         body: json.encode(session.toJsonUpdate()),
//       );

//       if (response.statusCode != 200) {
//         throw Exception(
//             'Error al actualizar el estado de la sesión: ${response.body}');
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }
// }

// // class WorkSessionService {
// //   static Future<void> startWorkSession(WorkSession session) async {
// //     try {
// //       print('START SESSION DATA:');
// //       print(json.encode(session.toJsonStart()));
// //     } catch (e) {
// //       rethrow;
// //     }
// //   }

// //   static Future<void> endWorkSession(WorkSession session) async {
// //     try {
// //       print('END SESSION DATA:');
// //       print(json.encode(session.toJsonEnd()));
// //     } catch (e) {
// //       rethrow;
// //     }
// //   }

// //   static Future<void> updateWorkSession(WorkSession session) async {
// //     try {
// //       print('UPDATE SESSION DATA:');
// //       print(json.encode(session.toJsonUpdate()));
// //     } catch (e) {
// //       rethrow;
// //     }
// //   }
// // }

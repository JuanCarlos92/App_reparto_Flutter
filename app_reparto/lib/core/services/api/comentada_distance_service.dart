// // ignore_for_file: avoid_print

//... GRAPH HOPPER API...

// import 'package:app_reparto/core/config/api.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class DistanceService {
//   static Future<int> getDistanceMatrix(double originLat, double originLng,
//       double destLat, double destLng) async {
//     final url = Uri.parse('${Api.graphHopperApi}'
//         '?point=$originLat,$originLng'
//         '&point=$destLat,$destLng'
//         '&vehicle=car'
//         '&locale=es'
//         '&key=${Api.graphHopperKey}');

//     try {
//       print(
//           'Distance - Consultando tiempo de viaje para destino: $destLat,$destLng');
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);

//         // GraphHopper devuelve el tiempo en milisegundos, lo convertimos a segundos
//         if (data['paths'] != null && data['paths'].isNotEmpty) {
//           final timeInMs = data['paths'][0]['time'];
//           final timeInSeconds = (timeInMs / 1000).round();
//           print('Distance - Tiempo estimado: $timeInSeconds segundos');
//           return timeInSeconds;
//         }
//         print('Distance - Estructura de respuesta inválida: $data');
//       }
//       return 0;
//     } catch (e) {
//       print('Error - Al obtener tiempo de viaje: $e');
//       return 0;
//     }
//   }
// }

// ... GOOGLE API ...

// import 'package:app_reparto/core/config/api.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class DistanceService {
//   // Método estático que obtiene la matriz de distancia/tiempo entre un origen y un destino
//   // Retorna la duración del viaje en segundos
//   static Future<int> getDistanceMatrix(double originLat, double originLng,
//       double destLat, double destLng) async {
//     final origin = '$originLat,$originLng';
//     final destination = '$destLat,$destLng';

//     // Construye la URL para la petición a la API
//     final url = Uri.parse('${Api.distanceMaps}'
//         '?origins=$origin'
//         '&destinations=$destination'
//         '&mode=driving'
//         '&language=es'
//         '&units=metric'
//         '&key=${Api.distanceKey}');

//     try {
//       print('Debug - Consultando tiempo de viaje para destino: $destination');
//       // Realiza la petición HTTP
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         // Decodifica la respuesta JSON
//         final data = json.decode(response.body);

//         // Verifica que la respuesta tenga la estructura esperada
//         if (data['status'] == 'OK' &&
//             data['rows'] != null &&
//             data['rows'].isNotEmpty &&
//             data['rows'][0]['elements'] != null &&
//             data['rows'][0]['elements'].isNotEmpty) {
//           final element = data['rows'][0]['elements'][0];

//           // Si la duración está disponible, la retorna
//           if (element['status'] == 'OK' && element['duration'] != null) {
//             final duration = element['duration']['value'];
//             print('Debug - Tiempo estimado: $duration segundos');
//             return duration;
//           }
//         }
//         print('Debug - Estructura de respuesta inválida: $data');
//       }
//       return 0;
//     } catch (e) {
//       print('Error - Al obtener tiempo de viaje: $e');
//       return 0;
//     }
//   }
// }

// // ignore_for_file: avoid_print

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../../config/api.dart';

// class GraphhopperService {
//   Future<Map<String, dynamic>> drawRouteAndGetTime(
//       LatLng currentPosition, double destLat, double destLng) async {
//     final String url = '${Api.graphHopperApi}'
//         '?point=${currentPosition.latitude},${currentPosition.longitude}'
//         '&point=$destLat,$destLng'
//         '&vehicle=car'
//         '&locale=es'
//         '&calc_points=true'
//         '&points_encoded=false'
//         '&key=${Api.graphHopperKey}';

//     try {
//       final response = await http.get(Uri.parse(url));
//       final data = json.decode(response.body);

//       // Verificar si hay mensaje de error de límite excedido
//       if (data['message']?.contains('API limit') ?? false) {
//         return {
//           'polylines': <Polyline>{},
//           'duration': 0,
//           'error': 'API_LIMIT_EXCEEDED'
//         };
//       }

//       if (response.statusCode == 200 && data['paths'] != null && data['paths'].isNotEmpty) {
//         final path = data['paths'][0];
//         List<LatLng> points = _decodePolyline(path['points']['coordinates']);
//         final timeInSeconds = (path['time'] / 1000).round();

//         return {
//           'polylines': {
//             Polyline(
//               polylineId: const PolylineId('route'),
//               points: points,
//               color: Colors.blue,
//               width: 5,
//             ),
//           },
//           'duration': timeInSeconds,
//         };
//       }

//       print('Error - Respuesta de API inválida: ${response.body}');
//       return {'polylines': <Polyline>{}, 'duration': 0};
//     } catch (e) {
//       print('Error dibujando ruta: $e');
//       return {'polylines': <Polyline>{}, 'duration': 0};
//     }
//   }

//   List<LatLng> _decodePolyline(List<dynamic> coordinates) {
//     List<LatLng> points = [];
//     for (var coord in coordinates) {
//       points.add(LatLng(coord[1], coord[0]));
//     }
//     return points;
//   }
// }

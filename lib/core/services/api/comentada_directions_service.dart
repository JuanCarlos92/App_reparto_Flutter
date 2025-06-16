// // ignore_for_file: avoid_print

//... GRAPH HOPPER API...

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../../config/api.dart';

// class DirectionsService {
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
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data['paths'] != null && data['paths'].isNotEmpty) {
//           final path = data['paths'][0];
//           List<LatLng> points = _decodePolyline(path['points']['coordinates']);
//           final timeInSeconds = (path['time'] / 1000).round();

//           return {
//             'polylines': {
//               Polyline(
//                 polylineId: const PolylineId('route'),
//                 points: points,
//                 color: Colors.blue,
//                 width: 5,
//               ),
//             },
//             'duration': timeInSeconds,
//           };
//         }
//       }
//       print('Error - Respuesta de API inválida: ${response.body}');
//       return {'polylines': {}, 'duration': 0};
//     } catch (e) {
//       print('Error dibujando ruta: $e');
//       return {'polylines': {}, 'duration': 0};
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

// ... GOOGLE API ...

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../../config/api.dart';

// class DirectionsService {
//   // Dibuja la ruta entre la posición actual y el destino
//   Future<Set<Polyline>> drawRoute(
//       LatLng currentPosition, double destLat, double destLng) async {
//     final String url = '${Api.directionsMaps}'
//         '?origin=${currentPosition.latitude},${currentPosition.longitude}'
//         '&destination=$destLat,$destLng'
//         '&mode=driving'
//         '&language=es'
//         '&key=${Api.directionKey}';

//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data['status'] == 'OK') {
//           List<LatLng> points =
//               _decodePolyline(data['routes'][0]['overview_polyline']['points']);
//           return {
//             Polyline(
//               polylineId: const PolylineId('route'),
//               points: points,
//               color: Colors.blue,
//               width: 5,
//             ),
//           };
//         }
//       }
//       return {};
//     } catch (e) {
//       print('Error dibujando ruta: $e');
//       return {};
//     }
//   }

//   List<LatLng> _decodePolyline(String encoded) {
//     List<LatLng> points = [];
//     int index = 0, len = encoded.length;
//     int lat = 0, lng = 0;

//     while (index < len) {
//       int b, shift = 0, result = 0;
//       do {
//         b = encoded.codeUnitAt(index++) - 63;
//         result |= (b & 0x1F) << shift;
//         shift += 5;
//       } while (b >= 0x20);
//       int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//       lat += dlat;

//       shift = 0;
//       result = 0;
//       do {
//         b = encoded.codeUnitAt(index++) - 63;
//         result |= (b & 0x1F) << shift;
//         shift += 5;
//       } while (b >= 0x20);
//       int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//       lng += dlng;

//       points.add(LatLng(lat / 1E5, lng / 1E5));
//     }
//     return points;
//   }
// }

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../config/api.dart';

class GraphhopperRouteService {
  Future<Set<Polyline>> getRoute(
      LatLng currentPosition, double destLat, double destLng) async {
    final String url = '${Api.graphHopperApi}'
        '?point=${currentPosition.latitude},${currentPosition.longitude}'
        '&point=$destLat,$destLng'
        '&vehicle=car'
        '&locale=es'
        '&calc_points=true'
        '&points_encoded=false'
        '&key=${Api.graphHopperKey}';

    try {
      print('Solicitando ruta a: $url');
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);

      print('Respuesta de API: ${response.body}');

      if (data['message']?.contains('API limit') ?? false) {
        print('Límite de API excedido');
        return <Polyline>{};
      }

      if (response.statusCode == 200 &&
          data['paths'] != null &&
          data['paths'].isNotEmpty) {
        final path = data['paths'][0];
        if (path['points'] == null || path['points']['coordinates'] == null) {
          print('Error: No se encontraron coordenadas en la respuesta');
          return <Polyline>{};
        }

        List<LatLng> points = _decodePolyline(path['points']['coordinates']);
        print('Puntos decodificados: ${points.length}');

        if (points.isEmpty) {
          print('Error: No se pudieron decodificar puntos de la ruta');
          return <Polyline>{};
        }

        return {
          Polyline(
            polylineId: const PolylineId('route'),
            points: points,
            color: Colors.blue,
            width: 5,
          ),
        };
      }

      print('Error - Respuesta de API inválida: ${response.body}');
      return <Polyline>{};
    } catch (e) {
      print('Error obteniendo ruta: $e');
      return <Polyline>{};
    }
  }

  List<LatLng> _decodePolyline(List<dynamic> coordinates) {
    List<LatLng> points = [];
    for (var coord in coordinates) {
      points.add(LatLng(coord[1], coord[0]));
    }
    return points;
  }
}

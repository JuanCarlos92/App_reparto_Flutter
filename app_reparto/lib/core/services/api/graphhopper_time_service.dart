// ignore_for_file: avoid_print

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../config/api.dart';

class GraphhopperTimeService {
  DateTime? _lastRequestTime;

  Future<int?> getEstimatedTime(
      LatLng currentPosition, double destLat, double destLng) async {
    // Controlar la frecuencia de las solicitudes
    if (_lastRequestTime != null) {
      final timeSinceLastRequest = DateTime.now().difference(_lastRequestTime!);
      if (timeSinceLastRequest.inMilliseconds < 200) {
        await Future.delayed(
            Duration(milliseconds: 200) - timeSinceLastRequest);
      }
    }

    final String url = '${Api.graphHopperApi}'
        '?point=${currentPosition.latitude},${currentPosition.longitude}'
        '&point=$destLat,$destLng'
        '&vehicle=car'
        '&locale=es'
        '&key=${Api.graphHopperKey}';

    try {
      _lastRequestTime = DateTime.now();
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);

      if (data['message']?.contains('API limit') ?? false) {
        print('Límite de API excedido');
        return null;
      }

      if (response.statusCode == 200 &&
          data['paths'] != null &&
          data['paths'].isNotEmpty) {
        final path = data['paths'][0];
        if (path['time'] != null) {
          return (path['time'] / 1000).round();
        }
      }

      print('Error - Respuesta de API inválida: ${response.body}');
      return null;
    } catch (e) {
      print('Error calculando tiempo: $e');
      return null;
    }
  }
}

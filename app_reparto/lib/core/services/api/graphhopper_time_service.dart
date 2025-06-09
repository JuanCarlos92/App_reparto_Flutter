// ignore_for_file: avoid_print

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../config/api.dart';

class GraphhopperTimeService {
  Future<int> getEstimatedTime(
      LatLng currentPosition, double destLat, double destLng) async {
    final String url = '${Api.graphHopperApi}'
        '?point=${currentPosition.latitude},${currentPosition.longitude}'
        '&point=$destLat,$destLng'
        '&vehicle=car'
        '&locale=es'
        '&key=${Api.graphHopperKey}';

    try {
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);

      if (data['message']?.contains('API limit') ?? false) {
        return 0;
      }

      if (response.statusCode == 200 &&
          data['paths'] != null &&
          data['paths'].isNotEmpty) {
        final path = data['paths'][0];
        return (path['time'] / 1000).round();
      }

      print('Error - Respuesta de API inválida: ${response.body}');
      return 0;
    } catch (e) {
      print('Error calculando tiempo: $e');
      return 0;
    }
  }
}

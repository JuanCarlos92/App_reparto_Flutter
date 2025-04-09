import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api_config.dart';
import 'geolocation_service.dart';

class MapService {
  // Instancia del servicio de geolocalización para obtener la posición actual
  final GeolocationService _geolocationService = GeolocationService();

  // Obtiene la posición actual del dispositivo y la convierte a LatLng
  Future<LatLng> getCurrentPosition() async {
    final position = await _geolocationService.determinarPosition();
    return LatLng(position.latitude, position.longitude);
  }

  // Crea los marcadores en el mapa para la ubicación actual y la del cliente
  Set<Marker> createMarkers(
      LatLng? currentPosition, double clientLat, double clientLng) {
    Set<Marker> markers = {
      // Marcador para la ubicación del cliente (naranja)
      Marker(
        markerId: const MarkerId('client_location'),
        position: LatLng(clientLat, clientLng),
        infoWindow: const InfoWindow(title: 'Cliente'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      ),
    };

    // Añade el marcador de la ubicación actual (azul) si está disponible
    if (currentPosition != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: currentPosition,
          infoWindow: const InfoWindow(title: 'Mi ubicación'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    }
    return markers;
  }

  // Dibuja la ruta entre la posición actual y el destino usando la API de Google Directions
  Future<Set<Polyline>> drawRoute(
      LatLng currentPosition, double destLat, double destLng) async {
    final String url = '${ApiConfig.directionsMapsUrl}'
        '?origin=${currentPosition.latitude},${currentPosition.longitude}'
        '&destination=$destLat,$destLng'
        '&mode=driving'
        '&language=es'
        '&key=${ApiConfig.directionApiKey}';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          // Decodifica los puntos de la ruta y crea una polilínea
          List<LatLng> points =
              _decodePolyline(data['routes'][0]['overview_polyline']['points']);
          return {
            Polyline(
              polylineId: const PolylineId('route'),
              points: points,
              color: Colors.blue,
              width: 5,
            ),
          };
        }
      }
      return {};
    } catch (e) {
      print('Error dibujando ruta: $e');
      return {};
    }
  }

  // Decodifica la cadena de puntos codificada que devuelve la API de Google
  // Convierte el formato polyline de Google a una lista de coordenadas LatLng
  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      // Decodifica la latitud
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      // Decodifica la longitud
      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      // Añade el punto decodificado a la lista
      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }
}

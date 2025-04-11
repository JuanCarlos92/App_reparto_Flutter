import 'package:app_reparto/config/api_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DistanceService {
  // Método estático que obtiene la matriz de distancia/tiempo entre un origen y un destino
  // Retorna la duración del viaje en segundos
  static Future<int> getDistanceMatrix(double originLat, double originLng,
      double destLat, double destLng) async {
    final origin = '$originLat,$originLng';
    final destination = '$destLat,$destLng';

    // Construye la URL para la petición a la API
    final url = Uri.parse('${ApiConfig.distanceMaps}'
        '?origins=$origin'
        '&destinations=$destination'
        '&mode=driving'
        '&language=es'
        '&units=metric'
        '&key=${ApiConfig.distanceKey}');

    try {
      // ignore: avoid_print
      print('Debug - Consultando tiempo de viaje para destino: $destination');
      // Realiza la petición HTTP
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Decodifica la respuesta JSON
        final data = json.decode(response.body);

        // Verifica que la respuesta tenga la estructura esperada
        if (data['status'] == 'OK' &&
            data['rows'] != null &&
            data['rows'].isNotEmpty &&
            data['rows'][0]['elements'] != null &&
            data['rows'][0]['elements'].isNotEmpty) {
          final element = data['rows'][0]['elements'][0];

          // Si la duración está disponible, la retorna
          if (element['status'] == 'OK' && element['duration'] != null) {
            final duration = element['duration']['value'];
            // ignore: avoid_print
            print('Debug - Tiempo estimado: $duration segundos');
            return duration;
          }
        }
        // ignore: avoid_print
        print('Debug - Estructura de respuesta inválida: $data');
      }
      return 0;
    } catch (e) {
      // ignore: avoid_print
      print('Error - Al obtener tiempo de viaje: $e');
      return 0;
    }
  }
}

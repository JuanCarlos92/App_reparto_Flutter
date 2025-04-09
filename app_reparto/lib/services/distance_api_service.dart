import 'package:app_reparto/config/api_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DistanceApiService {
  // Método estático que obtiene la matriz de distancia/tiempo entre un origen y un destino
  // Retorna la duración del viaje en segundos
  static Future<int> getDistanceMatrix(String apiKey, double originLat,
      double originLng, double destLat, double destLng) async {
    // Formatea las coordenadas para la API
    final origin = '$originLat,$originLng';
    final destination = '$destLat,$destLng';

    // Construye la URL para la petición a la API
    final url = Uri.parse('${ApiConfig.distanceMapsUrl}'
        '?origins=$origin'
        '&destinations=$destination'
        '&mode=driving'
        '&language=es'
        '&units=metric'
        '&key=$apiKey');

    try {
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
            print('Debug - Tiempo estimado: ${duration} segundos');
            return duration;
          }
        }
        print('Debug - Estructura de respuesta inválida: $data');
      }
      // Retorna 0 si no se pudo obtener la duración
      return 0;
    } catch (e) {
      // Maneja cualquier error durante la petición
      print('Error - Al obtener tiempo de viaje: $e');
      return 0;
    }
  }
}

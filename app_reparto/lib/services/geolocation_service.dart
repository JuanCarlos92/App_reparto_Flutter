import 'package:geolocator/geolocator.dart';

class GeolocationService {
  // Metodo para determinar la posición actual del usuario
  Future<Position> determinarPosition() async {
    LocationPermission permission;
    // Variable para almacenar el permiso de ubicación
    permission = await Geolocator.checkPermission();

    // Si el permiso está denegado, solicita el permiso al usuario
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      // Si el permiso sigue denegado después de la solicitud, lanza un error
      if (permission == LocationPermission.denied) {
        return Future.error("error");
      }
    }

    // Si el permiso es concedido, obtiene la posición actual del usuario
    return await Geolocator.getCurrentPosition();
  }

  // Metodo para obtener la ubicación actual y mostrar la latitud y longitud
  Future<void> getCurrentLocation() async {
    Position position = await determinarPosition();
    // ignore: avoid_print
    print(position.latitude);
    // ignore: avoid_print
    print(position.longitude);
  }
}

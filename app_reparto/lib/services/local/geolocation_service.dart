import 'package:geolocator/geolocator.dart';

class GeolocationService {
  // Metodo para determinar la posición actual del usuario
  Future<Position> determinarPosition() async {
    LocationPermission permission;
    // Almacenar el permiso de ubicación
    permission = await Geolocator.checkPermission();

    // Si el permiso está denegado, solicita el permiso
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      // Si  sigue denegado, lanza un error
      if (permission == LocationPermission.denied) {
        return Future.error("error");
      }
    }

    // Si es concedido, obtiene la posicion
    return await Geolocator.getCurrentPosition();
  }

  // Metodo para obtener la ubicación actual
  Future<void> getCurrentLocation() async {
    Position position = await determinarPosition();
    // ignore: avoid_print
    print(position.latitude);
    // ignore: avoid_print
    print(position.longitude);
  }
}

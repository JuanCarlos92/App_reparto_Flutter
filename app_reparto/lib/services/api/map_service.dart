import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../local/geolocation_service.dart';

class MapService {
  final GeolocationService _geolocationService = GeolocationService();

  Future<LatLng> getCurrentPosition() async {
    final position = await _geolocationService.determinarPosition();
    return LatLng(position.latitude, position.longitude);
  }

  Set<Marker> createMarkers(
      LatLng? currentPosition, double clientLat, double clientLng) {
    Set<Marker> markers = {
      Marker(
        markerId: const MarkerId('client_location'),
        position: LatLng(clientLat, clientLng),
        infoWindow: const InfoWindow(title: 'Cliente'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      ),
    };

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
}

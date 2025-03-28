import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClientMapWidget extends StatelessWidget {
  final double latitude;
  final double longitude;

  const ClientMapWidget({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('client_location'),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(title: 'Ubicación del Cliente'),
          ),
        },
      ),
    );
  }
}

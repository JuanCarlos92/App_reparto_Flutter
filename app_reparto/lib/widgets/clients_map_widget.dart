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
    return Container(
      // Margen exterior del mapa
      margin: const EdgeInsets.all(16.0),

      // Decoración del contenedor del mapa
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2.0),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      // Widget para recortar el mapa según el radio del borde
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: SizedBox(
          // Altura del mapa
          height: 300,

          // Widget de Google Maps
          child: GoogleMap(
            // Configuración inicial de la cámara del mapa
            initialCameraPosition: CameraPosition(
              // Centro del mapa en la ubicación del cliente y zoom inicial
              target: LatLng(latitude, longitude),
              zoom: 15,
            ),

            // Marcador que indica la ubicación del cliente
            markers: {
              Marker(
                markerId: const MarkerId('client_location'),
                position: LatLng(latitude, longitude),
                infoWindow: InfoWindow(title: 'Ubicación del Cliente'),
              ),
            },
          ),
        ),
      ),
    );
  }
}

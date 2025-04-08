import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Widget para mostrar un mapa de Google Maps con la ubicación del cliente
class MapWidget extends StatelessWidget {
  // Coordenadas geográficas del cliente
  final double latitud; // Latitud del cliente
  final double longitud; // Longitud del cliente

  // Constructor que requiere las coordenadas
  const MapWidget({
    super.key,
    required this.latitud,
    required this.longitud,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0), // Margen uniforme alrededor del mapa
      // Decoración del contenedor del mapa
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2.0), // Borde blanco
        borderRadius: BorderRadius.circular(10.0), // Bordes redondeados
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.5), // Sombra semi-transparente
            spreadRadius: 5, // Extensión de la sombra
            blurRadius: 7, // Desenfoque de la sombra
            offset: const Offset(0, 3), // Posición de la sombra
          ),
        ],
      ),
      // Widget para recortar el mapa según el radio del borde
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: SizedBox(
          height: 300, // Altura fija del mapa
          // Widget de Google Maps
          child: GoogleMap(
            // Configuración inicial de la cámara del mapa
            initialCameraPosition: CameraPosition(
              target: LatLng(latitud,
                  longitud), // Centro del mapa en la ubicación del cliente
              zoom: 15, // Nivel de zoom inicial
            ),
            // Marcador que indica la ubicación del cliente
            markers: {
              Marker(
                markerId: const MarkerId('client_location'),
                position: LatLng(latitud, longitud),
                infoWindow: InfoWindow(
                    title: 'Ubicación del Cliente'), // Título del marcador
              ),
            },
          ),
        ),
      ),
    );
  }
}

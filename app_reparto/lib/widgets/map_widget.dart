import 'dart:math';

import 'package:app_reparto/core/services/api/map_service.dart';
import 'package:app_reparto/core/services/api/directions_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  // Coordenadas del destino (cliente)
  final double latitude;
  final double longitude;

  const MapWidget({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  // Controlador para manipular el mapa
  late GoogleMapController _mapController;
  // Servicio que maneja la lógica del mapa
  final MapService _mapService = MapService();
  // Servicio que maneja la lógica de la distancia
  final DirectionsService _directionsService = DirectionsService();
  // Posición actual del usuario
  LatLng? _currentPosition;
  // Conjunto de marcadores en el mapa (ubicación actual y cliente)
  Set<Marker> _markers = {};
  // Conjunto de líneas que forman la ruta
  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  // Inicializa el mapa obteniendo la ubicación actual y configurando marcadores y ruta
  Future<void> _initializeMap() async {
    try {
      final position = await _mapService.getCurrentPosition();

      if (mounted) {
        setState(() {
          _currentPosition = position;
          _markers = _mapService.createMarkers(
            _currentPosition,
            widget.latitude,
            widget.longitude,
          );
        });
        await _updateRoute();
        await _updateCamera();
      }
    } catch (e) {
      // ignore: avoid_print
      print('Debug - Error getting current location: $e');
    }
  }

  // Actualiza la ruta entre la ubicación actual y el destino
  Future<void> _updateRoute() async {
    if (_currentPosition != null) {
      final polylines = await _directionsService.drawRoute(
        _currentPosition!,
        widget.latitude,
        widget.longitude,
      );
      if (mounted) {
        setState(() {
          _polylines = polylines;
        });
      }
    }
  }

  // Ajusta la cámara del mapa para mostrar tanto el origen como el destino
  Future<void> _updateCamera() async {
    if (_currentPosition != null) {
      final bounds = LatLngBounds(
        southwest: LatLng(
          min(_currentPosition!.latitude, widget.latitude),
          min(_currentPosition!.longitude, widget.longitude),
        ),
        northeast: LatLng(
          max(_currentPosition!.latitude, widget.latitude),
          max(_currentPosition!.longitude, widget.longitude),
        ),
      );

      await _mapController.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, 50.0),
      );
    }
  }

  @override
  // Construye la interfaz del widget del mapa
  Widget build(BuildContext context) {
    return Container(
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: SizedBox(
          height: 300,
          // Widget de Google Maps con configuración inicial
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.latitude, widget.longitude),
              zoom: 15,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            markers: _markers,
            polylines: _polylines,
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
              _updateCamera();
            },
          ),
        ),
      ),
    );
  }
}

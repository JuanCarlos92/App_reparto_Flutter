// ignore_for_file: avoid_print

import 'dart:math';
import 'dart:async';
import 'package:app_reparto/core/services/api/map_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../core/services/api/graphhopper_route_service.dart';

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
  late GoogleMapController _mapController;
  final MapService _mapService = MapService();
  final GraphhopperRouteService _graphhopperRouteService =
      GraphhopperRouteService();
  LatLng? _currentPosition;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  Timer? _locationUpdateTimer;
  bool _isUpdatingRoute = false;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

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
        _startLocationUpdates();
      }
    } catch (e) {
      print('Debug - Error getting current location: $e');
    }
  }

  void _startLocationUpdates() {
    _locationUpdateTimer?.cancel();
    _locationUpdateTimer =
        Timer.periodic(const Duration(minutes: 1), (timer) async {
      if (!_isUpdatingRoute) {
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
          }
        } catch (e) {
          print('Error actualizando ubicación: $e');
        }
      }
    });
  }

  Future<void> _updateRoute() async {
    if (_currentPosition == null || _isUpdatingRoute) return;

    _isUpdatingRoute = true;
    try {
      final polylines = await _graphhopperRouteService.getRoute(
        _currentPosition!,
        widget.latitude,
        widget.longitude,
      );

      if (mounted) {
        setState(() {
          if (polylines.isNotEmpty) {
            _polylines = polylines;
          } else {
            print('No se recibieron polylines de la API');
          }
        });
      }
    } catch (e) {
      print('Error actualizando ruta: $e');
    } finally {
      _isUpdatingRoute = false;
    }
  }

  Future<void> _updateCamera() async {
    if (_currentPosition == null || !mounted) return;

    try {
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
    } catch (e) {
      print('Error actualizando cámara: $e');
    }
  }

  @override
  void dispose() {
    _locationUpdateTimer?.cancel();
    super.dispose();
  }

  @override
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

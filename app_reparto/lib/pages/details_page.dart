import 'package:app_reparto/widgets/clients_details_widget.dart';
import 'package:app_reparto/widgets/timer_widget.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String clientName;
  final String clientAddress;
  final double latitude;
  final double longitude;

  const DetailsPage({
    super.key,
    required this.clientName,
    required this.clientAddress,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0D3A21), // Verde muy oscuro
              Color(0xFF1E5631), // Verde oscuro principal
              Color(0xFF4FC98E), // Verde claro
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Centrar horizontalmente
          children: [
            // Header
            Container(
              padding: const EdgeInsets.fromLTRB(25, 60, 25, 20),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Centrar verticalmente
                children: [
                  const TimerWidget(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(height: 8.5),
            // Contenido principal
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 91, 92, 91),
                      Color.fromARGB(255, 232, 238, 235),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: ClientDetailsWidget(
                    clientName: clientName,
                    clientAddress: clientAddress,
                    latitude: latitude,
                    longitude: longitude,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

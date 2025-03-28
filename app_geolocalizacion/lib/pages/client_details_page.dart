import 'package:app_geolocalizacion/widgets/clients_details_widget.dart';
import 'package:app_geolocalizacion/widgets/header_widget.dart';
import 'package:flutter/material.dart';

class ClientDetailsPage extends StatelessWidget {
  final String clientName;
  final String clientAddress;
  final double latitude;
  final double longitude;

  const ClientDetailsPage({
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
            colors: [Colors.greenAccent, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderWidget(),
            ClientDetailsWidget(
              clientName: clientName,
              clientAddress: clientAddress,
              latitude: latitude,
              longitude: longitude,
            ),
          ],
        ),
      ),
    );
  }
}

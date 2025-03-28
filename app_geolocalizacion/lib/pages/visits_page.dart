import 'package:app_geolocalizacion/providers/clients_provider.dart';
import 'package:app_geolocalizacion/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/clients_list_widget.dart';

class VisitsPage extends StatelessWidget {
  const VisitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Cargar los clientes al iniciar la página
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ClientsProvider>().fetchClientsFromBackend();
    });
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.greenAccent, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const Column(
          children: [
            // Encabezado
            HeaderWidget(),
            // Lista de clientes
            ClientsListWidget(),
          ],
        ),
      ),
    );
  }
}

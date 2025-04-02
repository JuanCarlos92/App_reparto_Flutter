import 'package:app_reparto/widgets/timer_widget.dart';
import 'package:app_reparto/providers/clients_provider.dart';
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
          children: [
            // Header
            Container(
              padding: const EdgeInsets.fromLTRB(25, 60, 25, 20),
              child: Column(
                children: [
                  // const Icon(
                  //   Icons.location_on,
                  //   size: 42,
                  //   color: Colors.white,
                  // ),
                  // Timer display modularizado
                  const TimerWidget(),
                  const SizedBox(height: 10),
                  Text(
                    "Visitas Programadas",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      fontFamily: 'Roboto',
                      shadows: [
                        Shadow(
                          blurRadius: 8,
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
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
                    topRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: ClientsListWidget(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

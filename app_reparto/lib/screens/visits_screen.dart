import 'dart:async';

import 'package:app_reparto/widgets/timer_widget.dart';
import 'package:app_reparto/providers/clients_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/list_widget.dart';

// Página que muestra la lista de visitas programadas a clientes
class VisitsScreen extends StatefulWidget {
  const VisitsScreen({super.key});

  @override
  State<VisitsScreen> createState() => _VisitsScreenState();
}

class _VisitsScreenState extends State<VisitsScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Actualizar cada 1 segundo
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        context.read<ClientsProvider>().updateClientsWithDuration();
      }
    });

    // Actualización inicial
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ClientsProvider>().updateClientsWithDuration();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Carga los clientes después de que se construya el widget si la lista está vacía
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<ClientsProvider>().clients.isEmpty) {
        context.read<ClientsProvider>().fetchClientsFromBackend();
      }
    });

    return Scaffold(
      // Barra superior de la aplicación
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 200, 120, 20),
        centerTitle: true,
        title: const Text(
          'Visitas Programadas',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Roboto',
            shadows: [
              Shadow(
                blurRadius: 8,
                color: Color.fromRGBO(0, 0, 0, 0.3),
                offset: Offset(2, 2),
              ),
            ],
          ),
        ),
      ),
      // Contenedor principal de la página
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            // Sección superior con el widget del temporizador
            Container(
              padding: const EdgeInsets.fromLTRB(25, 60, 25, 20),
              child: Column(
                children: [
                  const TimerWidget(),
                ],
              ),
            ),
            const SizedBox(height: 20.5),

            // Contenedor principal con la lista de visitas
            Expanded(
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width *
                      0.9, // 90% del ancho de la pantalla
                  child: Container(
                    // Decoración del contenedor de la lista
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                      border: Border.all(
                        color: const Color.fromARGB(255, 200, 120, 20),
                        width: 1.5,
                      ),
                    ),
                    // Widget personalizado que muestra la lista de clientes
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child:
                          ListWidget(), // Widget que renderiza la lista de clientes
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Espacio inferior
          ],
        ),
      ),
    );
  }
}

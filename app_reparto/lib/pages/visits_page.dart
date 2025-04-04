import 'package:app_reparto/widgets/timer_widget.dart';
import 'package:app_reparto/providers/clients_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/list_widget.dart';

class VisitsPage extends StatelessWidget {
  const VisitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Cargar los clientes al iniciar la página
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ClientsProvider>().fetchClientsFromBackend();
    });

    return Scaffold(
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
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.fromLTRB(25, 60, 25, 20),
              child: Column(
                children: [
                  const TimerWidget(),
                ],
              ),
            ),
            const SizedBox(height: 20.5),
            // Contenido principal
            Expanded(
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Container(
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
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: ListWidget(),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:app_reparto/widgets/timer_widget.dart';
import 'package:app_reparto/providers/clients_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/bar_widget.dart';
import '../widgets/list_widget.dart';

class VisitsScreen extends StatefulWidget {
  const VisitsScreen({super.key});

  @override
  State<VisitsScreen> createState() => _VisitsScreenState();
}

class _VisitsScreenState extends State<VisitsScreen> with RouteAware {
  Timer? _timer;
  late RouteObserver<PageRoute> routeObserver;

  @override
  void initState() {
    super.initState();
    routeObserver = RouteObserver<PageRoute>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);

    // Actualizar tiempos cuando la pantalla se muestra
    final clientsProvider = context.read<ClientsProvider>();
    clientsProvider.updateClientsWithDuration();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _timer?.cancel();
    super.dispose();
  }

  @override
  void didPopNext() {
    if (!mounted) return;
    // Se ejecuta cuando se regresa a esta pantalla
    final clientsProvider = context.read<ClientsProvider>();

    // Ejecutamos las operaciones asíncronas de manera segura
    clientsProvider.fetchClientsFromBackend().then((_) {
      if (!mounted) return;
      clientsProvider.updateClientsWithDuration();
    });
  }

  @override
  void didPushNext() {
    // Se ejecuta cuando se navega a otra pantalla
    _timer?.cancel();
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
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            // Padding superior para el logo
            Padding(
              padding: const EdgeInsets.only(top: 55, bottom: 5),
              child: Image.asset(
                'assets/reparto360.png',
                height: 60,
                fit: BoxFit.contain,
              ),
            ),
            // Sección superior con el widget del temporizador
            Container(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
              child: const Column(
                children: [
                  TimerWidget(),
                ],
              ),
            ),
            const SizedBox(height: 5),
            // Texto "Ruta del día" alineado a la izquierda
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Ruta del día',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ),
            // Lista de clientes directamente sin contenedor
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ListWidget(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BarWidget(),
    );
  }
}


    //         // Contenedor principal con la lista de visitas
    //         Expanded(
    //           child: Center(
    //             child: SizedBox(
    //               width: MediaQuery.of(context).size.width *
    //                   0.9, // 90% del ancho de la pantalla
    //               child: Container(
    //                 // Decoración del contenedor de la lista
    //                 decoration: BoxDecoration(
    //                   color: Colors.white,
    //                   borderRadius: const BorderRadius.all(Radius.circular(40)),
    //                   boxShadow: [
    //                     BoxShadow(
    //                       // ignore: deprecated_member_use
    //                       color: Colors.black.withOpacity(0.1),
    //                       blurRadius: 20,
    //                       spreadRadius: 5,
    //                     ),
    //                   ],
    //                   border: Border.all(
    //                     color: const Color.fromARGB(255, 200, 120, 20),
    //                     width: 1.5,
    //                   ),
    //                 ),
    //                 // Widget personalizado que muestra la lista de clientes
    //                 child: const Padding(
    //                   padding:
    //                       EdgeInsets.symmetric(horizontal: 20, vertical: 30),
    //                   child:
    //                       // Widget que renderiza la lista de clientes
    //                       ListWidget(),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //         const SizedBox(height: 20),
    //       ],
    //     ),
    //   ),
    // );

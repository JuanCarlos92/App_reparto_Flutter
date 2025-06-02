import 'package:app_reparto/providers/clients_provider.dart';
import 'package:app_reparto/core/services/backend/client_service.dart';
import 'package:app_reparto/core/utils/dialog.dart';
import 'package:app_reparto/widgets/detail_widget.dart';
import 'package:app_reparto/widgets/timer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/button_widget.dart';

class DetailScreen extends StatelessWidget {
  final String clienteID;
  final String clientName;
  final String clientAddress;
  final String clientTown;

  const DetailScreen({
    super.key,
    required this.clienteID,
    required this.clientName,
    required this.clientAddress,
    required this.clientTown,
  });

  @override
  Widget build(BuildContext context) {
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
            // Texto "Detalles del cliente" alineado a la izquierda
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Detalles del cliente',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Contenedor principal con los detalles y el botón
            Expanded(
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DetailWidget(
                          clientName: clientName,
                          clientAddress: clientAddress,
                          clientTown: clientTown,
                        ),
                        const Spacer(),
                        ButtonWidget(
                          text: 'ENTREGADO',
                          backgroundColor: const Color(0xFFD97B1E),
                          onPressed: () async {
                            final scaffoldMessenger = ScaffoldMessenger.of(context);
                            final navigator = Navigator.of(context);
                            final clientsProvider = Provider.of<ClientsProvider>(
                                context,
                                listen: false);

                            final signed =
                                await DialogUtils.showSignatureDialog(context);

                            if (signed == true) {
                              ClientService()
                                  .deleteClient(clienteID)
                                  .then((success) {
                                if (success) {
                                  clientsProvider.fetchClientsFromBackend();
                                  scaffoldMessenger.showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Cliente entregado correctamente')),
                                  );
                                  navigator.pop();
                                }
                              }).catchError((e) {
                                scaffoldMessenger.showSnackBar(
                                  SnackBar(content: Text('Error: $e')),
                                );
                              });
                            }
                          },
                        ),
                      ],
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
